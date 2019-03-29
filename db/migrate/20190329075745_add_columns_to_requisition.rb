class AddColumnsToRequisition < ActiveRecord::Migration
  def change
    add_column :requisitions, :budget_type, :string
    add_reference :requisitions, :event, index: true, foreign_key: true
    add_reference :requisitions, :class_budget, index: true, foreign_key: true
  end
end
