class ItemCategory < ActiveRecord::Base
    has_many :products

    def name_with_code
        "#{code} [#{name}]"
    end
end
