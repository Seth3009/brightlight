class Room < ActiveRecord::Base

  has_many :room_accesses, dependent: :destroy
  has_many :badges, through: :room_access

  validates :room_name, presence: true
  validates :ip_address, uniqueness: true

  accepts_nested_attributes_for :room_accesses, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :badges
end
