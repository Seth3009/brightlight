require 'rails_helper'

RSpec.describe "class_periods/index", type: :view do
  before(:each) do
    assign(:class_periods, [
      ClassPeriod.create!(
        :name => "Name",
        :school => "School",
        :is_break => "Is Break"
      ),
      ClassPeriod.create!(
        :name => "Name",
        :school => "School",
        :is_break => "Is Break"
      )
    ])
  end

  it "renders a list of class_periods" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "School".to_s, :count => 2
    assert_select "tr>td", :text => "Is Break".to_s, :count => 2
  end
end
