require 'rails_helper'

RSpec.describe "warehouses/show", type: :view do
  before(:each) do
    @warehouse = assign(:warehouse, Warehouse.create!(
      :name => "Name",
      :room_number => "Room Number"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Room Number/)
  end
end
