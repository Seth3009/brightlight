class CreateRecurringTypes < ActiveRecord::Migration
  def change
    create_table :recurring_types do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
