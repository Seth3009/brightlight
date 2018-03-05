class AddForeignKeysForProcurementTables < ActiveRecord::Migration
  def change       
    add_foreign_key :requisitions, :budgets
    add_foreign_key :requisitions, :budget_items
    add_foreign_key :requisitions, :departments
    add_foreign_key :requisitions, :employees, column: :requester_id
    add_foreign_key :requisitions, :employees, column: :supervisor_id
    add_foreign_key :requisitions, :employees, column: :req_approver_id
    add_foreign_key :requisitions, :employees, column: :budget_approver_id
    add_foreign_key :requisitions, :employees, column: :purch_receiver_id
    add_foreign_key :requisitions, :users, column: :created_by_id
    add_foreign_key :requisitions, :users, column: :last_updated_by_id
        
    add_foreign_key :req_items, :requisitions
    add_foreign_key :req_items, :users, column: :created_by_id
    add_foreign_key :req_items, :users, column: :last_updated_by_id
        
    add_foreign_key :budgets, :departments 
    add_foreign_key :budgets, :employees, column: :budget_holder_id
    add_foreign_key :budgets, :employees, column: :approver_id
    add_foreign_key :budgets, :employees, column: :receiver_id
    add_foreign_key :budgets, :academic_years
    add_foreign_key :budgets, :users, column: :created_by_id
    add_foreign_key :budgets, :users, column: :last_updated_by_id
  
    add_foreign_key :budget_items, :budgets
    add_foreign_key :budget_items, :academic_years
    add_foreign_key :budget_items, :users, column: :created_by_id
    add_foreign_key :budget_items, :users, column: :last_updated_by_id
   
    add_foreign_key :purchase_orders, :suppliers
    add_foreign_key :purchase_orders, :departments
    add_foreign_key :purchase_orders, :employees, column: :approver_id
    add_foreign_key :purchase_orders, :employees, column: :requestor_id
    add_foreign_key :purchase_orders, :users, column: :created_by_id
    add_foreign_key :purchase_orders, :users, column: :last_updated_by_id

    add_foreign_key :order_items, :purchase_orders
    add_foreign_key :order_items, :stock_items
    add_foreign_key :order_items, :users, column: :created_by_id
    add_foreign_key :order_items, :users, column: :last_updated_by_id

    add_foreign_key :deliveries, :purchase_orders
    add_foreign_key :deliveries, :employees, column: :accepted_by_id
    add_foreign_key :deliveries, :employees, column: :checked_by_id
    add_foreign_key :deliveries, :users, column: :created_by_id
    add_foreign_key :deliveries, :users, column: :last_updated_by_id

    add_foreign_key :delivery_items, :deliveries
    add_foreign_key :delivery_items, :order_items
    add_foreign_key :delivery_items, :employees, column: :accepted_by_id
    add_foreign_key :delivery_items, :employees, column: :checked_by_id
    add_foreign_key :delivery_items, :users, column: :created_by_id
    add_foreign_key :delivery_items, :users, column: :last_updated_by_id
  end
end
