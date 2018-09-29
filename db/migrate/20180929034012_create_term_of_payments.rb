class CreateTermOfPayments < ActiveRecord::Migration
  def change
    create_table :term_of_payments do |t|
      t.string :name
      t.string :description
      t.string :notes
      t.boolean :active

      t.timestamps null: false
    end
  end
end
