class RawFood < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  has_many :food_packages

  accepts_nested_attributes_for :food_packages, allow_destroy: true, reject_if: :all_blank

  after_save :total_stock

  def total_stock
    total = 0    
    @fp = food_packages.all
    @fp.each do |fp|      
      total = (Measurement.parse(total.to_s + " " + self.unit) + Measurement.parse((fp.qty * fp.package_contents).to_s + " " + fp.unit)).quantity
    end
    self.update_column :stock, total    
  end
end
