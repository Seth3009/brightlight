class AddEnglishTitleToDiknasCourse < ActiveRecord::Migration
  def change
    add_column :diknas_courses, :title, :string
  end
end
