class CreateMessageRecipients < ActiveRecord::Migration
  def change
    create_table :message_recipients do |t|
      t.references :recipient, index: true, references: :users
      t.references :msg_group, index: true
      t.references :message, index: true
      t.boolean :is_read, default: false
      t.string :type

      t.timestamps null: false
    end

    add_foreign_key :message_recipients, :users, column: :recipient_id
    add_foreign_key :message_recipients, :msg_groups, column: :msg_group_id
    add_foreign_key :message_recipients, :messages, column: :message_id
  end
end
