class AddColumnToBudgetItems < ActiveRecord::Migration
  def change
    add_column :budget_items, :year, :integer
    remove_reference :budget_items, :academic_year, index: true
  end
end
