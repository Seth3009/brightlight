class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :acc_l1
      t.string :acc_l2
      t.string :acc_l3
      t.string :acc_l4
      t.string :description
      t.string :notes

      t.timestamps null: false
    end
  end
end
