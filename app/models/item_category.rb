class ItemCategory < ActiveRecord::Base
    has_many :supplies

    def name_with_code
        "#{code} [#{name}]"
    end
end
