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
      t.references :reminder, index: true
      t.string :tags
      t.references :msg_folder, index: true

      t.timestamps null: false
    end

    add_foreign_key :messages, :users, column: :creator_id
    add_foreign_key :messages, :messages, column: :parent_id
    add_foreign_key :messages, :reminders, column: :reminder_id
  end
end
