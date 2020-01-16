class AddSomeColumnsToStudent < ActiveRecord::Migration
  def change
    add_column :students, :child_order, :string
    add_column :students, :school_from, :string
    add_column :students, :accepted_grade, :string
    add_column :students, :accepted_date, :date
  end
end
