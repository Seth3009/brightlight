class CreateUserMesgGroups < ActiveRecord::Migration
  def change
    create_table :user_mesg_groups do |t|
      t.references :recipient, index: true
      t.references :msg_group, index: true
      t.boolean :is_admin, default: false
      t.boolean :is_active, default: true

      t.timestamps null: false
    end

    add_foreign_key :user_mesg_groups, :users, column: :recipient_id
    add_foreign_key :user_mesg_groups, :msg_groups, column: :msg_group_id
  end
end
