class DiknasConversion < ActiveRecord::Base
  belongs_to :diknas_course
  belongs_to :diknas_academic_year
  belongs_to :diknas_academic_term

  has_many :diknas_conversion_items, -> { order(:id) }, dependent: :destroy  
  validate :has_at_least_one_diknas_conversion_item
  
  accepts_nested_attributes_for :diknas_conversion_items,
    allow_destroy: true,
    reject_if: proc { |attributes| attributes['course_id'].blank? }
  
  private
    def has_at_least_one_diknas_conversion_item     
      errors.add :diknas_conversion, 'must have at least one item' if diknas_conversion_items.empty?
    end
end
