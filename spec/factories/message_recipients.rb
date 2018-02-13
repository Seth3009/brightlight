FactoryGirl.define do
  factory :message_recipient do
    recipient nil
    recipient_group nil
    message nil
    is_read false
    type ""
  end
end
