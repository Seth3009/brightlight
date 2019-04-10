class LunchMenu < ActiveRecord::Base
  belongs_to :food
  belongs_to :academic_year
  validates_presence_of :food_id

  after_save :update_total

  def start_time
    self.lunch_date
  end
  
  private
    def update_total      
      sum_adj = self.adj_g1 + self.adj_g4 + self.adj_sol + self.adj_sor + self.adj_adult
      self.update_column :total_adj, sum_adj
    end
end
