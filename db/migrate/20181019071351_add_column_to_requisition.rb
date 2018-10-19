class AddColumnToRequisition < ActiveRecord::Migration
  def change
    add_column :requisitions, :status, :string
  end
end
