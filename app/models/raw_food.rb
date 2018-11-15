class RawFood < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  has_many :food_packages

  accepts_nested_attributes_for :food_packages, allow_destroy: true, reject_if: :all_blank
end
