class AddGradeSectionStudentTardy < ActiveRecord::Migration
  def change
    add_reference :student_tardies, :grade_section, index: true
  end
end
