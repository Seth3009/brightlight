class AddNisnColumnToStudent < ActiveRecord::Migration
  def change
    add_column :students, :nisn, :string
  end
end
