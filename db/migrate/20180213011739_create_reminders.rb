class CreateReminders < ActiveRecord::Migration
  def change
    create_table :reminders do |t|
      t.references :recurring_type, index: true, foreign_key: true
      t.integer :separation_count
      t.integer :max_num
      t.integer :day_of_week
      t.integer :week_of_month
      t.integer :day_of_month
      t.integer :month_of_year

      t.timestamps null: false
    end

  end
end
