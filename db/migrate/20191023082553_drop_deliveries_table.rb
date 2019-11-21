class DropDeliveriesTable < ActiveRecord::Migration
  def up
    remove_index :delivery_items, :accepted_by_id
    remove_index :delivery_items, :checked_by_id
    remove_index :delivery_items, :created_by_id
    remove_index :delivery_items, :delivery_id
    remove_index :delivery_items, :last_updated_by_id
    remove_index :delivery_items, :order_item_id
    remove_column :delivery_items, :accepted_by_id
    remove_column :delivery_items, :checked_by_id
    remove_column :delivery_items, :created_by_id
    remove_column :delivery_items, :delivery_id
    remove_column :delivery_items, :last_updated_by_id
    remove_column :delivery_items, :order_item_id
    drop_table :delivery_items

    remove_index :deliveries, :accepted_by_id
    remove_index :deliveries, :checked_by_id
    remove_index :deliveries, :created_by_id
    remove_index :deliveries, :last_updated_by_id
    remove_index :deliveries, :purchase_order_id
    remove_column :deliveries, :accepted_by_id
    remove_column :deliveries, :checked_by_id
    remove_column :deliveries, :created_by_id
    remove_column :deliveries, :last_updated_by_id
    remove_column :deliveries, :purchase_order_id
    drop_table :deliveries
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
