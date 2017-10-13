class CreateBudgetItems < ActiveRecord::Migration
  def change
    create_table :budget_items do |t|
      t.belongs_to, :budget
      t.string :description,
      t.string :account,
      t.integer, :line
      t.string :notes,
      t.belongs_to, :academic_year
      t.integer, :month
      t.decimal, :amount
      t.decimal, :actual_amt
      t.boolean, :is_completed
      t.string :type,
      t.string :category,
      t.string :group
      t.references :created_by, references: users, index: true
      t.references :last_updated_by, references: users, index: true

      t.timestamps null: false
    end
    
    add_foreign_key :budget_items, :users, column: :created_by
    add_foreign_key :budget_items, :users, column: :last_updated_by
  end
end
