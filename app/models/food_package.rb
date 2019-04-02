class FoodPackage < ActiveRecord::Base  
  validates_presence_of :packaging, :message => "Packaging can't be blank"
  validates_presence_of :package_contents, :message => "Amount of content can't be blank"
  validates_presence_of :unit, :message => "Unit can't be blank"
  
  belongs_to :raw_food 
  has_many :food_packages_food_suppliers
  has_many :food_order_items
  has_many :food_delivery_items
  after_save :update_stock
  after_destroy :update_stock

  scope :search_index_query, lambda { |query|
    return nil  if query.blank?   
      # condition query, parse into individual keywords
      terms = query.downcase.split(/\s+/)

      # replace "*" with "%" for wildcard searches,
      # append '%', remove duplicate '%'s
      terms = terms.map { |e|
        ('%' + e.gsub('*', '%') + '%').gsub(/%+/, '%')
      }
      # configure number of OR conditions for provision
      # of interpolation arguments. Adjust this if you
      # change the number of OR conditions.
      num_or_conds = 2
        joins("left join raw_foods on raw_foods.id = food_packages.raw_food_id")     
        .where(
        terms.map { |term|
          "(LOWER(name) LIKE ? OR LOWER(packaging) LIKE ?)"
        }.join(' AND '),
        *terms.map { |e| [e] * num_or_conds }.flatten
      )
  }

  scope :search_query, lambda { |query, food_supplier|
    return nil  if query.blank?   
      # condition query, parse into individual keywords
      terms = query.downcase.split(/\s+/)

      # replace "*" with "%" for wildcard searches,
      # append '%', remove duplicate '%'s
      terms = terms.map { |e|
        ('%' + e.gsub('*', '%') + '%').gsub(/%+/, '%')
      }
      # configure number of OR conditions for provision
      # of interpolation arguments. Adjust this if you
      # change the number of OR conditions.
      num_or_conds = 2      
      joins("left join raw_foods on raw_foods.id = food_packages.raw_food_id")
      .joins("left join food_packages_food_suppliers on food_packages_food_suppliers.food_package_id = food_packages.id")
      .where("food_packages_food_suppliers.food_supplier_id = ? and raw_foods.is_stock = ?", food_supplier, true)      
      .where(
        terms.map { |term|
          "(LOWER(name) LIKE ? OR LOWER(packaging) LIKE ?)"
        }.join(' AND '),
        *terms.map { |e| [e] * num_or_conds }.flatten
      )
  }

  def unit_food
    "#{Measurement.parse(package_contents.to_s + unit).convert_to(self.raw_food.unit).quantity}"
  end
  
  def update_stock
    raw_food.total_stock
  end  
  
  def update_qty
    qty = 0
    @items_in = food_order_items.all
    @items_out = food_delivery_items.all
    @items_in.each do |item|
      qty = qty + (item.qty_received || 0)
    end
    @items_out.each do |item|
      qty = qty - (item.qty || 0)
    end
    self.update_column :qty, qty
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
