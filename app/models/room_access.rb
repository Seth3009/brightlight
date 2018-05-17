class RoomAccess < ActiveRecord::Base
  belongs_to :room
  belongs_to :badge

  validates :badge, uniqueness: {:scope => [:room]}
end
