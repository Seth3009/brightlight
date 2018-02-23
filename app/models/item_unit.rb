class ItemUnit < ActiveRecord::Base
    has_many :supplies

    def name_with_abbr
      "#{abbreviation} [#{name}] "
    end
end
