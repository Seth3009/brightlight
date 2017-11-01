class CreateBudgets < ActiveRecord::Migration
  def change
    create_table :budgets do |t|
      t.belongs_to :department, index: true
      t.belongs_to :grade_level
      t.belongs_to :grade_section
      t.belongs_to :budget_holder, references: :employees, index: true
      t.belongs_to :academic_year, index: true
      t.boolean :is_submitted
      t.date :submit_date
      t.boolean :is_approved
      t.date :approved_date
      t.references :approver, references: :employees, index: true
      t.boolean :is_received
      t.references :receiver, references: :employees, index: true
      t.date :received_date
      t.decimal :total_amt
      t.string :notes
      t.string :category
      t.string :type
      t.string :group
      t.string :version
      t.references :created_by, references: :users, index: true
      t.references :last_updated_by, references: :users, index: true

      t.timestamps null: false
    end

  end
end
