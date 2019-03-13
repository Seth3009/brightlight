class FoodPackage < ActiveRecord::Base  
  validates_presence_of :packaging, :message => "Packaging can't be blank"
  validates_presence_of :package_contents, :message => "Amount of content can't be blank"
  validates_presence_of :unit, :message => "Unit can't be blank"
  
  belongs_to :raw_food 
  has_many :food_packages_food_suppliers
  after_save :update_stock

  def update_stock
    raw_food.total_stock
  end    

  def self.disable_item(food_package)
    if self.find(food_package).is_active?
      self.find(food_package).update(:is_active => false)
    else
      self.find(food_package).update(:is_active => true)
    end
  end

  def self.select_food_item(food_supplier)
    self.find_by_sql("select CONCAT(t1.name,' ',t1.packaging) as packaging, t1.id, t2.food_package_id, t2.food_supplier_id 
                    from (select food_packages.id, packaging, name from food_packages left join raw_foods on raw_foods.id = food_packages.raw_food_id) t1
                    left join (select food_package_id, food_supplier_id from food_packages_food_suppliers where food_supplier_id =" + food_supplier.to_s + ") t2
                    on (t1.id = t2.food_supplier_id) where t2.food_package_id is null order by t1.packaging")
  end
end
