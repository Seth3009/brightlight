class MessageRecipient < ActiveRecord::Base
  belongs_to :recipient, class_name: "User"
  belongs_to :msg_group
  belongs_to :message

end
