class AddColumnSortNumToDiknasCourse < ActiveRecord::Migration
  def change
    add_column :diknas_courses, :sort_num, :integer
  end
end
