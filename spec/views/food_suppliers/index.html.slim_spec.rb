require 'rails_helper'

RSpec.describe "food_suppliers/index", type: :view do
  before(:each) do
    assign(:food_suppliers, [
      FoodSupplier.create!(
        :supplier => "Supplier",
        :address => "Address",
        :contact_person => "Contact Person",
        :phone => "Phone"
      ),
      FoodSupplier.create!(
        :supplier => "Supplier",
        :address => "Address",
        :contact_person => "Contact Person",
        :phone => "Phone"
      )
    ])
  end

  it "renders a list of food_suppliers" do
    render
    assert_select "tr>td", :text => "Supplier".to_s, :count => 2
    assert_select "tr>td", :text => "Address".to_s, :count => 2
    assert_select "tr>td", :text => "Contact Person".to_s, :count => 2
    assert_select "tr>td", :text => "Phone".to_s, :count => 2
  end
end
