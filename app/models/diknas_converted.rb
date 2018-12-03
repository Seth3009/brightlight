class DiknasConverted < ActiveRecord::Base
  belongs_to :student
  belongs_to :academic_year
  belongs_to :academic_term
  belongs_to :grade_level

  has_many :diknas_converted_items, inverse_of: :diknas_converted
  accepts_nested_attributes_for :diknas_converted_items, reject_if: :all_blank, allow_destroy: true
end
