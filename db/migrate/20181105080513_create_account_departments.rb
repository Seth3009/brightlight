class CreateAccountDepartments < ActiveRecord::Migration
  def change
    create_table :account_departments do |t|
      t.belongs_to :account, index: true, foreign_key: true
      t.belongs_to :department, index: true, foreign_key: true
      t.string :notes

      t.timestamps null: false
    end
  end
end
