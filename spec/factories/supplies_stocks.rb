FactoryGirl.define do
  factory :supplies_stock do
    trx_date "2018-02-28"
    trx_type "MyString"
    qty 1.5
    trx_notes "MyString"
    supply nil
    user nil
    warehouse nil
  end
end
