class ChangeColumnTypeOnDiknasCourse < ActiveRecord::Migration
  def change
    change_column :diknas_courses, :number, 'integer USING CAST(number AS integer)'
  end
end
