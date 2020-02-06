class AddOccupationsToGuardian < ActiveRecord::Migration
  def change
    add_column :guardians, :occupations, :string    
  end
end
