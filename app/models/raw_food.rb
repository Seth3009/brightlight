class RawFood < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  has_many :food_packages
  has_many :recipes

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

  def self.disable_item(raw_food)
    if self.find(raw_food).is_active?
      self.find(raw_food).update(:is_active => false)
    else
      self.find(raw_food).update(:is_active => true)
    end
  end

  def self.select_raw_food(food_id)
    self.find_by_sql("select t1.name,t1.id,t2.raw_food_id,t2.food_id,t1.unit
                    From (select id, name, unit from raw_foods) t1
                    left join (select raw_food_id, food_id from recipes where food_id =" + food_id.to_s + ") t2
                    on (t1.id = t2.raw_food_id) where t2.raw_food_id is null order by t1.name")
  end

  def dropdown_name
    "#{name} (#{unit})"
  end
end
