class AddForeignKeysForProcurementTables < ActiveRecord::Migration
  def change       
    add_foreign_key :requisitions, :budgets
    add_foreign_key :requisitions, :budget_items
    add_foreign_key :requisitions, :departments
    add_foreign_key :requisitions, :users, column: :requester_id
    add_foreign_key :requisitions, :users, column: :supervisor_id
    add_foreign_key :requisitions, :users, column: :created_by_id
    add_foreign_key :requisitions, :users, column: :last_updated_by_id
        
    add_foreign_key :req_items, :requisitions
    add_foreign_key :req_items, :users, column: :created_by_id
    add_foreign_key :req_items, :users, column: :last_updated_by_id
        
    add_foreign_key :budgets, :departments 
    add_foreign_key :budgets, :users, column: :budget_holder_id
    add_foreign_key :budgets, :users, column: :approver_id
    add_foreign_key :budgets, :users, column: :receiver_id
    add_foreign_key :budgets, :academic_years
    add_foreign_key :budgets, :users, column: :created_by_id
    add_foreign_key :budgets, :users, column: :last_updated_by_id
  
    add_foreign_key :budget_items, :budgets
    add_foreign_key :budget_items, :academic_years
    add_foreign_key :budget_items, :users, column: :created_by_id
    add_foreign_key :budget_items, :users, column: :last_updated_by_id
   
    add_foreign_key :purchase_orders, :suppliers
    add_foreign_key :purchase_orders, :departments
    add_foreign_key :purchase_orders, :users, column: :approver_id
    add_foreign_key :purchase_orders, :users, column: :requestor_id
    add_foreign_key :purchase_orders, :users, column: :created_by_id
    add_foreign_key :purchase_orders, :users, column: :last_updated_by_id

    add_foreign_key :order_items, :purchase_orders
    add_foreign_key :order_items, :stock_items
    add_foreign_key :order_items, :users, column: :created_by_id
    add_foreign_key :order_items, :users, column: :last_updated_by_id

    add_foreign_key :deliveries, :purchase_orders
    add_foreign_key :deliveries, :users, column: :accepted_by_id
    add_foreign_key :deliveries, :users, column: :checked_by_id
    add_foreign_key :deliveries, :users, column: :created_by_id
    add_foreign_key :deliveries, :users, column: :last_updated_by_id

    add_foreign_key :delivery_items, :deliveries
    add_foreign_key :delivery_items, :order_items
    add_foreign_key :delivery_items, :users, column: :accepted_by_id
    add_foreign_key :delivery_items, :users, column: :checked_by_id
    add_foreign_key :delivery_items, :users, column: :created_by_id
    add_foreign_key :delivery_items, :users, column: :last_updated_by_id
  end
end
