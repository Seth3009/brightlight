require 'rails_helper'

RSpec.describe "warehouses/index", type: :view do
  before(:each) do
    assign(:warehouses, [
      Warehouse.create!(
        :name => "Name",
        :room_number => "Room Number"
      ),
      Warehouse.create!(
        :name => "Name",
        :room_number => "Room Number"
      )
    ])
  end

  it "renders a list of warehouses" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Room Number".to_s, :count => 2
  end
end
