class Guardian < ActiveRecord::Base
	validates :name, presence: true, uniqueness: {scope: :family_id}
	belongs_to :family
	belongs_to :person	
	has_one :family_member, dependent: :destroy

	def self.for_email_and_family(email, family_id)
		return nil if email.nil? || family_id.nil?
		Guardian.where('TRIM(UPPER(email)) = ?', email.strip.upcase)
			.where(family_id: family_id)
			.take
	end

	def self.for_name_and_family(name, family_id)
		return nil if name.nil? || family_id.nil?
		Guardian.where('TRIM(UPPER(name)) = ?', name.strip.upcase)
			.where(family_id: family_id)
			.take
	end
	
	def self.including_family_no
		joins(:family).select('guardians.*, families.family_no as fn')
	end

end
