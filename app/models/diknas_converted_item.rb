class DiknasConvertedItem < ActiveRecord::Base
  belongs_to :diknas_converted
  belongs_to :diknas_conversion
  validates :p_score, :t_score, presence: true

  scope :with_courses, lambda { 
    joins(:diknas_conversion)
    .joins('join diknas_courses on diknas_courses.id=diknas_conversions.diknas_course_id')
  }

  # school_scores calculate Nilai Sekolah as average of 3 values of last year Semester I and II scores and this year's Semester I score
  # Try Out 2 scores is taken from nat_exams.try_out_2 value
  # Grouped by Student and Diknas Course
  scope :school_scores, lambda { |academic_year_id:|
    with_courses
    .joins(:diknas_converted)
    .joins('join students on diknas_converteds.student_id = students.id')
    .where(diknas_converteds: {academic_year_id: [academic_year_id.to_i - 1, academic_year_id.to_i]})
    .joins('left outer join nat_exams ne on ne.student_id=students.id and  ne.diknas_course_id=diknas_courses.id')
    .group('students.id, students.name, diknas_courses.id, diknas_courses.name, ne.try_out_2')
    .select("students.id as sid, students.name as student_name, 
              diknas_courses.id as course_id, diknas_courses.name as course, 
              ROUND(AVG(p_score)) as nilai_sekolah, ne.try_out_2 as try_out_2")
    .order('diknas_courses.id')
  }

  scope :student_scores, lambda {|student_id:, academic_year_id:|
    school_scores(academic_year_id: academic_year_id)
    .where(diknas_converteds: {student_id: student_id} )
  }

  scope :student_score_for_diknas_course, lambda { |student_id:, academic_year_id:, diknas_course_id:|
    student_scores(student_id: student_id, academic_year_id: academic_year_id)
    .where(diknas_conversions: {diknas_course_id: diknas_course_id})
  }

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
