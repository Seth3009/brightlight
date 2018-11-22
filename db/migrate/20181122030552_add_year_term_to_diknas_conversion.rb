class AddYearTermToDiknasConversion < ActiveRecord::Migration
  def change
    add_reference :diknas_conversions, :diknas_academic_year, index: true, foreign_key: true
    add_reference :diknas_conversions, :diknas_academic_term, index: true, foreign_key: true
  end
end
