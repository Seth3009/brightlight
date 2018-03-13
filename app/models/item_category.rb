class ItemCategory < ActiveRecord::Base
  has_many :products, dependent: :restrict_with_error

  def name_with_code
      "#{code} [#{name}]"
  end
end
