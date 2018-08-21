class AddColumnLeadershipsToEmployee < ActiveRecord::Migration
  def change
    add_column :employees, :leaderships, :boolean, default: false
  end
end
