class CreateBatchStudents < ActiveRecord::Migration
  def change
    create_table :batch_students do |t|
      t.belongs_to :batch, index: true, foreign_key: true
      t.belongs_to :student, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
