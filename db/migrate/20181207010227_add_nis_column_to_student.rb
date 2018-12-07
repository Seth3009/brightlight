class AddNisColumnToStudent < ActiveRecord::Migration
  def change
    add_column :students, :nis, :string
  end
end
