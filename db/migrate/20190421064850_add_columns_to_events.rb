class AddColumnsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :aasm_status, :string
    add_column :events, :active, :boolean
    add_reference :events, :creator, index: true, foreign_key: true
    add_column :events, :budget, :decimal
  end
end
