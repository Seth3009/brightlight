class CreateRequisitions < ActiveRecord::Migration
  def change
    create_table :requisitions do |t|
      t.string :req_no
      t.string :description
      t.boolean :is_budgeted
      t.references :budget, index: true
      t.references :budget_item, index: true
      t.date :date_required
      t.date :date_requested
      t.belongs_to :department, index: true
      t.belongs_to :requester, references: :users, index: true
      t.belongs_to :supervisor, references: :users, index: true
      t.boolean :supv_approval
      t.string :notes
      t.string :appvl_notes
      t.string :total_amt
      t.boolean :is_budget_approved
      t.boolean :is_submitted
      t.boolean :is_approved
      t.boolean :is_sent_to_supv
      t.boolean :is_sent_to_purchasing
      t.boolean :is_sent_for_bgt_approval
      t.boolean :is_rejected
      t.string :reject_reason
      t.boolean :active
      t.references :created_by, references: :users, index: true
      t.references :last_updated_by, references: :users, index: true

      t.timestamps null: false
    end

  end
end
