require 'rails_helper'

RSpec.describe "raw_foods/index", type: :view do
  before(:each) do
    assign(:raw_foods, [
      RawFood.create!(
        :name => "Name",
        :is_stock => false
      ),
      RawFood.create!(
        :name => "Name",
        :is_stock => false
      )
    ])
  end

  it "renders a list of raw_foods" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
