class Event < ActiveRecord::Base
  belongs_to :department
  belongs_to :manager
end
