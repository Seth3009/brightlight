class Student < ActiveRecord::Base
	has_many :students_guardians
	has_many :guardians, through: :students_guardians
	has_many :grade_sections, through: :grade_sections_students
	has_many :course_sections, through: :rosters

  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |student|
        csv << student.attributes.values_at(*column_names)
      end
    end
  end
end
