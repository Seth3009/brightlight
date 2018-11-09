class AddAccountToRequisition < ActiveRecord::Migration
  def change
    add_reference :requisitions, :account, index: true, foreign_key: true
  end
end
