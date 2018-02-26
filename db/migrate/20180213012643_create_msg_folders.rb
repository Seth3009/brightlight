class CreateMsgFolders < ActiveRecord::Migration
  def change
    create_table :msg_folders do |t|
      t.string :name
      t.string :tag
      t.references :parent, index: true, references: :msg_folders
      t.string :badge

      t.timestamps null: false
    end

    add_foreign_key :msg_folders, :msg_folders, column: :parent_id
  end
end
