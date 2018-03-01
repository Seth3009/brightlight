class SuppliesStock < ActiveRecord::Base
  belongs_to :supply
  belongs_to :user
  belongs_to :warehouse
end
