class AddDefaultToEvent < ActiveRecord::Migration
  def down
    change_column :events, :active, :boolean
    remove_reference :events, :academic_year, index: true, foreign_key: true
  end

  def up
    change_column :events, :active, :boolean, default: true
    add_reference :events, :academic_year, index: true, foreign_key: true
  end
end
