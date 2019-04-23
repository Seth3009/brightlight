class CreateClassBudgets < ActiveRecord::Migration
  def change
    create_table :class_budgets do |t|
      t.belongs_to :department, index: true, foreign_key: true
      t.belongs_to :grade_level, index: true, foreign_key: true
      t.belongs_to :grade_section, index: true, foreign_key: true
      t.belongs_to :holder, references: :employees, index: true
      t.belongs_to :academic_year, index: true, foreign_key: true
      t.integer :month
      t.decimal :amount
      t.decimal :balance
      t.decimal :actual
      t.string :notes

      t.timestamps null: false
    end
  end
end
