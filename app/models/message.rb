class Message < ActiveRecord::Base
  belongs_to :creator, class_name: "User", foreign_key: 'creator_id'
  belongs_to :parent, class_name: "Message", foreign_key: 'parent_id'
  belongs_to :remind_frequency
  belongs_to :folder

  has_many :recipients
  has_one  :reminder

  scope :active, lambda { |user| joins(:recipients).where(recipient: user).where(is_read: false)}
end
