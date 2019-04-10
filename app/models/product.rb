class Product < ActiveRecord::Base
  belongs_to :item_unit
  belongs_to :item_category
  validates_uniqueness_of :code
  validates_presence_of :code
  validates_presence_of :item_unit
  validates_presence_of :item_category
  has_many :supplies_transaction_item

  after_create :assign_barcode

  scope :active, lambda { where(is_active:true).order(:name) }

  scope :get_all, lambda { includes([:item_category, :item_unit]) }
  
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

  def self.supplies_stock(date,sort,direction)
    self.find_by_sql("select t1.id,t1.name, t1.barcode, t1.min_stock, t1.item_unit_id, t1.packs, t1.packs_unit, t1.is_active, (sum(CASE WHEN in_out = 'IN' THEN qty ELSE 0 END) - sum(CASE WHEN in_out ='OUT' THEN qty ELSE 0 END)) as stock from
    (select products.* from products) t1
    left join (select supplies_transaction_items.*, supplies_transactions.transaction_date from supplies_transaction_items left join supplies_transactions
          on supplies_transactions.id = supplies_transaction_items.supplies_transaction_id where supplies_transactions.transaction_date <= '" + date + "') t2
    on (t2.product_id = t1.id)
    group by t1.id, t1.name,t1.barcode,t1.min_stock,t1.item_unit_id, t1.packs, t1.packs_unit, t1.is_active
    order by " + sort + " " + direction)
  end

  private 
    def assign_barcode
      update_columns barcode: sprintf("SPL-9%06i", id)
    end
  
end
