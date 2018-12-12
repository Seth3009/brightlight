class DiknasConversionList < ActiveRecord::Base
  belongs_to :diknas_conversion
  belongs_to :conversion, class_name: 'DiknasConversion'
end
