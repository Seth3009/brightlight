class Food < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  has_many :recipes
  has_many :raw_foods, through: :recipes

  accepts_nested_attributes_for :recipes, allow_destroy: true, reject_if: :all_blank
  
  after_save :ingredient_count
  def ingredient_count
    self.update_column :ingredients, recipes.count
  end

  scope :active, lambda { where(is_active:true).order(:name) }
  
  scope :search_query, lambda { |query|
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
      num_or_conds = 1      
      where(
        terms.map { |term|
          "(LOWER(name) LIKE ?)"
        }.join(' AND '),
        *terms.map { |e| [e] * num_or_conds }.flatten
      )
  }

  def self.disable_item(food)
    if self.find(food).is_active?
      self.find(food).update(:is_active => false)
    else
      self.find(food).update(:is_active => true)
    end
  end
end
