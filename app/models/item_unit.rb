class ItemUnit < ActiveRecord::Base
    has_many :products

    def name_with_abbr
      "#{abbreviation} [#{name}] "
    end
end
