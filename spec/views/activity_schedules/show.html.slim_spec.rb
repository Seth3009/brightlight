require 'rails_helper'

RSpec.describe "activity_schedules/show", type: :view do
  before(:each) do
    @activity_schedule = assign(:activity_schedule, ActivitySchedule.create!(
      :activity => "Activity",
      :is_active => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Activity/)
    expect(rendered).to match(/false/)
  end
end
