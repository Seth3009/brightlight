FactoryGirl.define do
  factory :reminder do
    message nil
    recurring_type nil
    separation_count 1
    max_num 1
    day_of_week 1
    week_of_month 1
    day_of_month 1
    month_of_year 1
  end
end
