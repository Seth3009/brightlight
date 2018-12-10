class AddColumnToDiknasCourse < ActiveRecord::Migration
  def change
    add_column :diknas_courses, :number2, :integer
  end
end
