class CreateFundRequests < ActiveRecord::Migration
  def change
    create_table :fund_requests do |t|
      t.integer :requester_id
      t.date :date_requested
      t.date :date_needed
      t.string :description
      t.decimal :amount
      t.boolean :is_cash
      t.string :transfer_to
      t.string :bank_name
      t.string :bank_account_number
      t.string :bank_city
      t.boolean :is_budgeted
      t.string :budget_notes
      t.boolean :is_spv_approved
      t.string :spv_approval_notes
      t.date :spv_approval_date
      t.boolean :is_hos_approved
      t.string :hos_approval_notes
      t.date :hos_approval_date
      t.integer :receiver_id
      t.date :received_date
      t.boolean :is_transfered

      t.timestamps null: false
    end
  end
end
