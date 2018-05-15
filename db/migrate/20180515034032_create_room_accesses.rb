class CreateRoomAccesses < ActiveRecord::Migration
  def change
    create_table :room_accesses do |t|
      t.references :room, index: true, foreign_key: true
      t.references :badge, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
