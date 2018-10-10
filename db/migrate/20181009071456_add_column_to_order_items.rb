class AddColumnToOrderItems < ActiveRecord::Migration
  def change
    add_reference :order_items, :req_item, index: true, foreign_key: true
  end
end
