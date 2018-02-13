class CreateMsgGroups < ActiveRecord::Migration
  def change
    create_table :msg_groups do |t|
      t.string :name
      t.references :creator, index: true, references: :users
      t.boolean :is_active, default: true
      t.string :image_url

      t.timestamps null: false
    end

    add_foreign_key :msg_groups, :users, column: :creator_id
  end
end
