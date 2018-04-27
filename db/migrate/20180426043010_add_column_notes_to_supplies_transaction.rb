class AddColumnNotesToSuppliesTransaction < ActiveRecord::Migration
  def change
    add_column :supplies_transactions, :notes, :string
  end
end
