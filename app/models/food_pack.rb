class FoodPack < ActiveRecord::Base
  validates :academic_year, presence: true, uniqueness: true
  belongs_to :academic_year

  after_save :update_total
  
  def self.g1_g3(food_pack)    
    food_pack.g1 + food_pack.g2 + food_pack.g3
  end

  def self.g4_g6(food_pack)    
    food_pack.g4 + food_pack.g5 + food_pack.g6
  end

  def self.sol(food_pack)    
    food_pack.g7 + food_pack.g8 + food_pack.g9
  end

  def self.sor(food_pack)    
    food_pack.g10 + food_pack.g11 + food_pack.g12
  end

  private
    def update_total      
      sum_pack = self.g1 + self.g2 + self.g3 + self.g4 + self.g5 + self.g6
               + self.g7 + self.g8 + self.g9 + self.g10 + self.g11 + self.g12 + self.employee
      self.update_column :total, sum_pack
    end

end
