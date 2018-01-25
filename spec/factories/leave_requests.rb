FactoryGirl.define do
  factory :leave_request do
    start_date "2018-01-25"
    end_date "2018-01-25"
    hour "MyString"
    leave_type "MyString"
    leave_note "MyString"
    leave_subtitute false
    subtitute_notes "MyText"
    spv_approval false
    spv_date "2018-01-25"
    spv_notes "MyText"
    hr_approval false
    hr_date "2018-01-25"
    hr_notes "MyText"
    form_submit_date "2018-01-25"
    leave_attachment "MyString"
    employee nil
  end
end
