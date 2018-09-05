class Supplier < ActiveRecord::Base
  belongs_to :created_by, class_name: 'User'
  belongs_to :last_updated_by, class_name: 'User'

  validates :company_name, presence: true
  validates :address1, :city, presence: true
end
