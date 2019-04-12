class AddDateToStudentTardy < ActiveRecord::Migration
  def change
    add_column :student_tardies, :date_tardy, :date
  end
end
