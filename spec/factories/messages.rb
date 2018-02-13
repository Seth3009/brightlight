FactoryGirl.define do
  factory :message do
    subject "MyString"
    creator nil
    body "MyString"
    parent nil
    expiry_date "2018-02-13"
    is_reminder false
    next_remind_date "2018-02-13"
    remind_frequency nil
    tags "MyString"
    folder nil
  end
end
