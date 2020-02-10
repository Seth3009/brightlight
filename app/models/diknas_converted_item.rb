class DiknasConvertedItem < ActiveRecord::Base
  belongs_to :diknas_converted
  belongs_to :diknas_conversion
  validates :p_score, :t_score, presence: true

  scope :un_courses, lambda { 
    joins(:diknas_conversion)
    .joins('join diknas_courses on diknas_courses.id=diknas_conversions.diknas_course_id')
    .where(diknas_courses: {name: DiknasCourse::TRYOUTCOURSES})
  }

  scope :school_scores, lambda { |academic_year_id:|
    un_courses
    .joins(:diknas_converted)
    .joins('join students on diknas_converteds.student_id = students.id')
    .where(diknas_converteds: {academic_year_id: [academic_year_id - 1, academic_year_id]})
    .select("students.id as sid, students.name as student_name, 
             diknas_courses.id as course_id, diknas_courses.name as course, 
             diknas_converteds.grade_level_id as grade_level,
             AVG(p_score) as avg_score")
    .group('sid, student_name, course_id, course, grade_level')
  }

  scope :student_scores, lambda {|student_id:, academic_year_id:|
    school_scores(academic_year_id: academic_year_id)
    .where(diknas_converteds: {student_id: student_id} )
  }

  # SELECT students.id as sid, students.name as student_name, 
  #            diknas_courses.id as course_id, diknas_courses.name as course, 
  #            AVG(p_score) as avg_score 
  # FROM "diknas_converted_items" 
  # INNER JOIN "diknas_conversions" 
  # ON "diknas_conversions"."id" = "diknas_converted_items"."diknas_conversion_id" 
  # INNER JOIN "diknas_converteds" ON "diknas_converteds"."id" = "diknas_converted_items"."diknas_converted_id" 
  # join diknas_courses on diknas_courses.id=diknas_conversions.diknas_course_id 
  # join students on diknas_converteds.student_id = students.id 
  # WHERE "diknas_courses"."name" IN ('BAHASA INDONESIA', 'BAHASA INGGRIS', 'MATEMATIKA', 'FISIKA', 'BIOLOGI', 'KIMIA', 'SEJARAH', 'SOSIOLOGI') AND "diknas_converteds"."academic_year_id" IN (18, 19) AND "diknas_converteds"."student_id" = 577 
  # GROUP BY sid, student_name, course_id, course

  def self.in_words(int)
    huruf = Array.new
    word_array = ["Nol","Satu","Dua","Tiga","Empat","Lima","Enam","Tujuh","Delapan","Sembilan","Seratus"]
    if int.to_i == 100
      return "Seratus"
    else
      int.to_i.to_s.split(//).each do |str|
        huruf << word_array[str.to_i]
      end
      return huruf.join(' ')
    end   
  end
  
end
