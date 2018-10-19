class CreateReqStatuses < ActiveRecord::Migration
  def change
    create_table :req_statuses do |t|
      t.string :code
      t.string :desription

      t.timestamps null: false
    end
  end
end
