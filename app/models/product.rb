class Product < ActiveRecord::Base
  belongs_to :item_unit
  belongs_to :item_category
  validates_uniqueness_of :code
  validates_presence_of :code
  has_many :supplies_transaction_item

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
      num_or_conds = 2      
      where(
        terms.map { |term|
          "(LOWER(name) LIKE ? OR LOWER(code) LIKE ?)"
        }.join(' AND '),
        *terms.map { |e| [e] * num_or_conds }.flatten
      )
  }

  def self.disable_item(product)
    self.find(product).update(:is_active => false)
  end
end
