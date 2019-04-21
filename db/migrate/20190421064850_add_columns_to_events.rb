class AddColumnsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :aasm_state, :string
    add_column :events, :active, :boolean
    add_reference :events, :creator, index: true
    add_column :events, :budget, :decimal
  end
end
