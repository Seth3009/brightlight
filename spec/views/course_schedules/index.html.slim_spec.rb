require 'rails_helper'

RSpec.describe "course_schedules/index", type: :view do
  before(:each) do
    assign(:course_schedules, [
      CourseSchedule.create!(
        :course => nil,
        :course_section => nil,
        :class_period => nil,
        :room => nil,
        :active => false,
        :academic_term => nil
      ),
      CourseSchedule.create!(
        :course => nil,
        :course_section => nil,
        :class_period => nil,
        :room => nil,
        :active => false,
        :academic_term => nil
      )
    ])
  end

  it "renders a list of course_schedules" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
