class AddColumnToReqItem < ActiveRecord::Migration
  def change
    add_reference :req_items, :order_item, index: true, foreign_key: true
  end
end
