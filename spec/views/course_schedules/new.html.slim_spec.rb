require 'rails_helper'

RSpec.describe "course_schedules/new", type: :view do
  before(:each) do
    assign(:course_schedule, CourseSchedule.new(
      :course => nil,
      :course_section => nil,
      :class_period => nil,
      :room => nil,
      :active => false,
      :academic_term => nil
    ))
  end

  it "renders new course_schedule form" do
    render

    assert_select "form[action=?][method=?]", course_schedules_path, "post" do

      assert_select "input#course_schedule_course_id[name=?]", "course_schedule[course_id]"

      assert_select "input#course_schedule_course_section_id[name=?]", "course_schedule[course_section_id]"

      assert_select "input#course_schedule_class_period_id[name=?]", "course_schedule[class_period_id]"

      assert_select "input#course_schedule_room_id[name=?]", "course_schedule[room_id]"

      assert_select "input#course_schedule_active[name=?]", "course_schedule[active]"

      assert_select "input#course_schedule_academic_term_id[name=?]", "course_schedule[academic_term_id]"
    end
  end
end
