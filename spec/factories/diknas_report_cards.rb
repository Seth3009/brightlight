FactoryGirl.define do
  factory :diknas_report_card do
    student nil
    grade_level nil
    grade_section nil
    academic_year nil
    academic_term nil
    course_belongs_to "MyString"
    average 1.5
    notes "MyText"
  end
end
