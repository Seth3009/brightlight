class UserMesgGroup < ActiveRecord::Base
  belongs_to :user
  belongs_to :msg_group
end
