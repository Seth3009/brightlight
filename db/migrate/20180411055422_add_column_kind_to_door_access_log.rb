class AddColumnKindToDoorAccessLog < ActiveRecord::Migration
  def change
    add_column :door_access_logs, :kind, :string
  end
end
