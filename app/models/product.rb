class Product < ActiveRecord::Base
  belongs_to :item_unit
  belongs_to :item_category
  validates_uniqueness_of :code
  validates_presence_of :code
  has_many :supplies_transaction_item

  after_create :assign_barcode

  scope :active, lambda { where(is_active:true).order(:name) }

  scope :get_all, lambda { joins('left join item_units on item_units.id = item_unit_id')
                      .joins('left join item_categories on item_categories.id = item_category_id')}
  
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
    if self.find(product).is_active?
      self.find(product).update(:is_active => false)
    else
      self.find(product).update(:is_active => true)
    end
  end

  private 
    def assign_barcode
      update_columns barcode: sprintf("SPL-9%06i", id)
    end
  
end
