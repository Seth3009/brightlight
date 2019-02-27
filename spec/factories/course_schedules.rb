FactoryGirl.define do
  factory :course_schedule do
    course nil
    course_section nil
    class_period nil
    room nil
    active false
    academic_term nil
  end
end
