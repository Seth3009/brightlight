class CreateBadges < ActiveRecord::Migration
  def change
    create_table :badges do |t|
      t.string :code
      t.string :detail
      t.belongs_to :student
      t.belongs_to :employee
      t.string :kind
      t.string :name
      t.boolean :active

      t.timestamps null: false
    end
  end
end
