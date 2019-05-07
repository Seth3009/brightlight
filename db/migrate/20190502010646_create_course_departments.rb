class CreateCourseDepartments < ActiveRecord::Migration
  def change
    create_table :course_departments do |t|
      t.string :name
      t.string :description
      t.string :notes
      t.boolean :active, default: true

      t.timestamps null: false
    end
  end
end
