require 'rails_helper'

RSpec.describe "class_periods/show", type: :view do
  before(:each) do
    @class_period = assign(:class_period, ClassPeriod.create!(
      :name => "Name",
      :school => "School",
      :is_break => "Is Break"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/School/)
    expect(rendered).to match(/Is Break/)
  end
end
