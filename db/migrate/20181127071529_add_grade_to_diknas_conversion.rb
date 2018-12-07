class AddGradeToDiknasConversion < ActiveRecord::Migration
  def change
    add_reference :diknas_conversions, :grade_level, foreign_key: true
  end
end
