class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :subject
      t.references :creator, references: :users, index: true
      t.string :body
      t.references :parent, references: :messages, index: true
      t.date :expiry_date
      t.boolean :is_reminder
      t.date :next_remind_date
      t.string :tags
      t.references :msg_folder, index: true

      t.timestamps null: false
    end

    add_foreign_key :messages, :users, column: :creator_id
    
  end
end
