require 'rails_helper'

RSpec.describe "activity_schedules/index", type: :view do
  before(:each) do
    assign(:activity_schedules, [
      ActivitySchedule.create!(
        :activity => "Activity",
        :is_active => false
      ),
      ActivitySchedule.create!(
        :activity => "Activity",
        :is_active => false
      )
    ])
  end

  it "renders a list of activity_schedules" do
    render
    assert_select "tr>td", :text => "Activity".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
