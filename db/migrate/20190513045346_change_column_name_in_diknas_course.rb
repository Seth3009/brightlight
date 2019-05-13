class ChangeColumnNameInDiknasCourse < ActiveRecord::Migration
  def change
    rename_column :diknas_courses, :number, :ipa10
    rename_column :diknas_courses, :number2, :ips10
  end
end
