class AddColumnsToDiknasCourse < ActiveRecord::Migration
  def change
    add_column :diknas_courses, :ipa12, :integer
    add_column :diknas_courses, :ips12, :integer
    add_column :diknas_courses, :ipa11, :integer
    add_column :diknas_courses, :ips11, :integer
  end
end
