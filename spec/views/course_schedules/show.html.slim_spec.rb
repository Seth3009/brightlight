require 'rails_helper'

RSpec.describe "course_schedules/show", type: :view do
  before(:each) do
    @course_schedule = assign(:course_schedule, CourseSchedule.create!(
      :course => nil,
      :course_section => nil,
      :class_period => nil,
      :room => nil,
      :active => false,
      :academic_term => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/false/)
    expect(rendered).to match(//)
  end
end
