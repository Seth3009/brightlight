class DiknasConversionItem < ActiveRecord::Base
  belongs_to :diknas_conversion
  belongs_to :course
  belongs_to :academic_year
  belongs_to :academic_term
end
