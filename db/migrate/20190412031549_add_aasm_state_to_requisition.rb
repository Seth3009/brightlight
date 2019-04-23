class AddAasmStateToRequisition < ActiveRecord::Migration
  def change
    add_column :requisitions, :aasm_state, :string
  end
end
