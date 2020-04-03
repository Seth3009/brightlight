class NatExam < ActiveRecord::Base
  belongs_to :student
  belongs_to :grade_level
  belongs_to :academic_year
  belongs_to :diknas_course

  scope :for_academic_year, lambda { | year | where(academic_year_id: year) }
  # scope :scores_for, lambda { |student_id:|
  #   where(student_id: student_id)
  # }
  scope :wajib, lambda {
    joins(:diknas_course)
    .where(diknas_courses: {name: ["BAHASA INDONESIA", "BAHASA INGGRIS", "MATEMATIKA"] })
  }

  def self.students(academic_year:)
    Student.where(id: NatExam.for_academic_year(academic_year).pluck(:student_id))
    .order(:name)
  end

  def self.scores_for(student_id:, academic_year_id: AcademicYear.current_id)
    DiknasConvertedItem.student_scores student_id: student_id, academic_year_id: academic_year_id
  end

  def self.detail_scores_for(student_id:, academic_year_id: AcademicYear.current_id)
    sid = Student.find(student_id).id
    curr_year = AcademicYear.find(academic_year_id)
    grade11_year = AcademicYear.find(academic_year_id-1)
    grade10_year = AcademicYear.find(academic_year_id-2)
    terms = grade10_year.academic_terms.map(&:id)
    terms << grade11_year.academic_terms.first.id
    terms << grade11_year.academic_terms.second.id
    terms << curr_year.academic_terms.first.id
    query = %Q{
SELECT * FROM \
crosstab($$ \
select course.id, course.name as course_name, conv.academic_term_id as term, dci.p_score as score from diknas_converted_items dci \
join diknas_conversions conv on conv.id = dci.diknas_conversion_id \
join diknas_converteds rapor on rapor.id = dci.diknas_converted_id \
join diknas_courses course on course.id = conv.diknas_course_id \
where conv.academic_year_id in (#{grade10_year.id},#{grade11_year.id},#{curr_year.id}) \
and rapor.student_id = #{sid} \
UNION \
select course.id, course.name as course_name, 999 as term, round(avg(dci.p_score)) as score from diknas_converted_items dci \
join diknas_conversions conv on conv.id = dci.diknas_conversion_id \
join diknas_converteds rapor on rapor.id = dci.diknas_converted_id \
join diknas_courses course on course.id = conv.diknas_course_id \
where conv.academic_year_id in (#{grade10_year.id},#{grade11_year.id},#{curr_year.id}) and rapor.student_id = #{sid} \
group by course.id, course_name \
UNION \
select diknas_course_id, course.name as course_name, 1000 as term, try_out_2 as score \
from nat_exams \
join diknas_courses course on course.id = nat_exams.diknas_course_id \
where academic_year_id =#{curr_year.id} and student_id = #{sid} \
order by 1,2 \
$$, $$values (#{terms[0]}), (#{terms[1]}), (#{terms[2]}), (#{terms[3]}), (#{terms[4]}), (999), (1000)$$ \
) \
AS ct(course_id int, course varchar, "sem1" float, "sem2" float, "sem3" float, "sem4" float, "sem5" float, "avg" float, "to2" float) \
}
    NatExam.find_by_sql(query)
  end

  def self.import_to_ii_scores(xlsx_file:, sheet:, academic_year_id:)
    xl = Roo::Spreadsheet.open(xlsx_file)
    sheet = xl.sheet(sheet)

    header = {"ID" => 'id', "NAME" => 'student'}
    header.merge! DiknasCourse::TRYOUTCOURSES.reduce(Hash.new) {|acc,c| acc.merge( c => DiknasCourse.find_by_name(c).id)}
    
    sheet.each_with_index(header) do |row, i| 
      next if i < 1 
      DiknasCourse.all.order(:sort_num).each do |diknas_course_name|
        nilai_sekolah = DiknasConvertedItem.student_score_for_diknas_course(student_id:row["ID"], academic_year_id: academic_year_id, diknas_course_id: header[diknas_course_name]).take
        if nilai_sekolah.present? || row[diknas_course_name].present?
          record = NatExam.find_or_create_by student_id: row["ID"], 
            academic_year_id: academic_year_id, 
            diknas_course_id: header[diknas_course_name],
            grade_level_id: 12
          record.update try_out_2: row[diknas_course_name], nilai_sekolah: nilai_sekolah.avg_score
        end
      end
    end
  end

end
