class CreateLeaveRequests < ActiveRecord::Migration
  def change
    create_table :leave_requests do |t|
      t.date :start_date
      t.date :end_date
      t.string :hour
      t.string :leave_type
      t.string :leave_note
      t.boolean :leave_subtitute
      t.text :subtitute_notes
      t.boolean :spv_approval
      t.date :spv_date
      t.text :spv_notes
      t.boolean :hr_approval
      t.date :hr_date
      t.text :hr_notes
      t.date :form_submit_date
      t.string :leave_attachment
      t.belongs_to :employee, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
