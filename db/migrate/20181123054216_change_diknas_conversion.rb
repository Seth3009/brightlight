class ChangeDiknasConversion < ActiveRecord::Migration
  def change
    remove_reference :diknas_conversions, :course, index:true, foreign_key: true
    remove_reference :diknas_conversions, :academic_year, index:true, foreign_key: true
    remove_reference :diknas_conversions, :academic_term, index:true, foreign_key: true
    add_reference :diknas_conversions, :diknas_academic_year, index:true, foreign_key: true
    add_reference :diknas_conversions, :diknas_academic_term, index:true, foreign_key: true

  end
end
