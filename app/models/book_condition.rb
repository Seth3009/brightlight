class BookCondition < ActiveRecord::Base
	validates :code, presence: true, uniqueness: true
end
