class ChangeColumnTypesInRequisition < ActiveRecord::Migration
  def change
    remove_column :requisitions, :is_sent_to_supv, :boolean
    remove_column :requisitions, :is_sent_to_purchasing, :boolean
    remove_column :requisitions, :is_sent_for_bgt_approval, :boolean
    remove_column :requisitions, :supv_approval, :boolean
    remove_column :requisitions, :is_approved, :boolean

    add_column :requisitions, :is_supv_approved, :boolean
    add_column :requisitions, :budget_approved_date, :date
    add_column :requisitions, :supv_approved_date, :date
    add_column :requisitions, :sent_to_supv, :date
    add_column :requisitions, :sent_to_purchasing, :date
    add_column :requisitions, :sent_for_bgt_approval, :date
  end
end
