class AddColumnNoSkLulusToStudent < ActiveRecord::Migration
  def change
    add_column :students, :sk_lulus, :string
  end
end
