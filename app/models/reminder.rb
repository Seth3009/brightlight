class Reminder < ActiveRecord::Base
  belongs_to :message
  belongs_to :recurring_type
end
