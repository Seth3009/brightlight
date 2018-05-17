class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :room_code
      t.string :room_name
      t.string :location
      t.string :ip_address

      t.timestamps null: false
    end
  end
end
