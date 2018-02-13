class MessageRecipient < ActiveRecord::Base
  belongs_to :recipient
  belongs_to :recipient_group
  belongs_to :message
end
