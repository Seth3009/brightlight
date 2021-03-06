class TransportUniquenessValidator < ActiveModel::Validator
  def validate(record)
    now = Time.now
    range_start = now < Carpool.end_of_morning_period ? now.beginning_of_day : Carpool.end_of_morning_period
    range_end   = now < Carpool.end_of_morning_period ? Carpool.end_of_morning_period : now.end_of_day
    records = Carpool.where('created_at > ?', range_start)
                     .where('created_at < ?', range_end)
    if record.transport_name.present?
      records = records.where(transport_name: record.transport_name)
    elsif record.barcode.present?      
      records = records.where(barcode: record.barcode)
    else
      record.errors[:messages] << 'Invalid input'
    end    
    if records.present?
      record.errors[:messages] << 'Duplicate car'
    end
  end
end
  
class Carpool < ActiveRecord::Base
  include ActiveModel::Validations
  validates_with TransportUniquenessValidator, on: :create
  
  belongs_to :transport
  has_many :passengers, through: :transport
  has_many :late_passengers
  
  accepts_nested_attributes_for :late_passengers

  scope :since, lambda { |time| 
    where('carpools.updated_at > ?', Time.at((time.to_i/1000).to_i))
  }
  scope :private_cars, lambda { where(category:'private') }
  scope :shuttle_cars, lambda { where(category:'shuttle') }
  scope :active, lambda { where.not(status:'done') }
  scope :inactive, lambda { where(status:'done') }
  scope :today_am, lambda { where('created_at > ? and created_at < ?', Date.today.beginning_of_day, Carpool.end_of_morning_period) }
  scope :today_pm, lambda { where('created_at > ?', Carpool.end_of_morning_period) }
  scope :today, lambda { where('created_at > ?', Date.today.beginning_of_day) }

  before_create :fill_in_details
  # after_update  :sync_late_passengers

  # if id is a string with a length greater of 10 digits, it's assumed to be a RFID UID
  def self.find_uid(id)
    if id.to_s.length >= 10
      find_by_barcode id.to_s
    else
      find id
    end
  end

  def self.end_of_morning_period
    Date.today.noon             # 12:00
    # Date.today.noon + 1.hour  # 13:00
  end

  private

    def fill_in_details
      if barcode.present?
        transport = SmartCard.find_by_code(barcode).try(:transport)
      elsif transport_name.present?
        transport = Transport.find_by_name transport_name.upcase
        self.barcode = transport.smart_cards.first.try(:code) if transport.present?
      end 
      unless transport.present?
        return false
      end
      self.transport_id = transport.id
      self.transport_name = transport.name
      self.arrival = created_at
      self.period = arrival < Carpool.end_of_morning_period ? 0 : 1
      self.active = true
      self.category = transport.category   
    end

    def sync_late_passengers
      if status == 'done'
        self.late_passengers.update_all active:false
      end
    end

end
