class DiknasConversion < ActiveRecord::Base
  belongs_to :diknas_course
  belongs_to :academic_year
  belongs_to :academic_term
  belongs_to :grade_level
  has_many :diknas_converted_items
  has_many :diknas_conversion_items, inverse_of: :diknas_conversion
  accepts_nested_attributes_for :diknas_conversion_items, reject_if: :all_blank, allow_destroy: true
  
  private
    def has_at_least_one_diknas_conversion_item     
      errors.add :diknas_conversion, 'must have at least one item' if diknas_conversion_items.empty?
    end
end
