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

  def self.food_order(from,to, g1, g2, sol, sor, adult)
    self.find_by_sql("select raw_foods.*, 
                    SUM(CASE WHEN recipes.portion_size > 0
                    THEN recipes.portion_size * ((recipes.gr1_portion * " + g1.to_s + ") + (recipes.gr2_portion * " + g2.to_s + ") + (recipes.sol_portion * " + sol.to_s + ") + (recipes.sor_portion * " + sor.to_s + ") + (recipes.adult_portion * " + adult.to_s + "))
                    ELSE (recipes.qty/recipes.recipe_portion) * (" + g1.to_s + "+" + g2.to_s + "+" + sol.to_s + "+" + sor.to_s + "+" + adult.to_s + ") END) as cur_qty
                    from raw_foods left join recipes on recipes.raw_food_id = raw_foods.id
                    left join foods on foods.id = recipes.food_id
                    left join lunch_menus on lunch_menus.food_id = foods.id
                    where lunch_menus.lunch_date between '" + from + "' and '" + to + "' and raw_foods.is_stock = true
                    group by raw_foods.id order by raw_foods.name") 
  end

  def self.food_order_non_stock(from,to, g1, g2, sol, sor, adult, param)
    if param == "all"
      supp = ""
    else
      supp = " where id = " + param 
    end
    self.find_by_sql("select t1.*, t2.supplier,t2.price from
                    (select raw_foods.*, 
                    SUM(CASE WHEN recipes.portion_size > 0
                    THEN recipes.portion_size * ((recipes.gr1_portion * " + g1.to_s + ") + (recipes.gr2_portion * " + g2.to_s + ") + (recipes.sol_portion * " + sol.to_s + ") + (recipes.sor_portion * " + sor.to_s + ") + (recipes.adult_portion * " + adult.to_s + "))
                    ELSE (recipes.qty/recipes.recipe_portion) * (" + g1.to_s + "+" + g2.to_s + "+" + sol.to_s + "+" + sor.to_s + "+" + adult.to_s + ") END) as cur_qty
                    from raw_foods left join recipes on recipes.raw_food_id = raw_foods.id
                    left join foods on foods.id = recipes.food_id
                    left join lunch_menus on lunch_menus.food_id = foods.id
                    where lunch_menus.lunch_date between '" + from + "' and '" + to + "' and raw_foods.is_stock = false
                    group by raw_foods.id order by raw_foods.name) t1 
                    left join(select v.raw_food_id, v.packaging, v.price, z.supplier, z.id as supp_id
                      from (select r1.raw_food_id, r1.packaging, r.price, r.food_supplier_id
                        from (select a2.* 
                            from (select food_package_id, min(price) as min_price from food_packages_food_suppliers
                              group by food_package_id) a1 
                              inner join food_packages_food_suppliers a2
                              on a2.food_package_id = a1.food_package_id
                              and a2.price = a1.min_price) r
                              left join (select food_packages.* from food_packages) r1				  
                              on r.food_package_id = r1.id) v
                              left join (select food_suppliers.* from food_suppliers"+ supp +") z
                              on z.id = v.food_supplier_id 
                    ) t2 on (t1.id = t2.raw_food_id) where t2.supp_id != 0 order by t2.supplier,t1.name") 
  end

  def dropdown_name
    "#{name} (#{unit})"
  end
end
