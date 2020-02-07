class DiknasConvertedItem < ActiveRecord::Base
  belongs_to :diknas_converted
  belongs_to :diknas_conversion
  validates :p_score, :t_score, presence: true

  scope :un_courses, lambda { 
    joins(:diknas_conversion)
    .joins('join diknas_courses on diknas_courses.id=diknas_conversions.diknas_course_id')
    .where(diknas_courses: {name: DiknasCourse::TRYOUTCOURSES})
  }

  scope :school_scores, lambda { |student_id:, academic_year_id:|
    un_courses
    .joins(:diknas_converted)
    .joins('join students on diknas_converteds.student_id = students.id')
    .where(diknas_converteds: {student_id: student_id, academic_year_id: academic_year_id})
    .select('diknas_converted_items.*, students.id as student_id, students.name as name, 
             diknas_courses.id as course_id, diknas_courses.name as course')
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
