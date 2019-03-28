require 'rails_helper'

RSpec.describe "food_suppliers/show", type: :view do
  before(:each) do
    @food_supplier = assign(:food_supplier, FoodSupplier.create!(
      :supplier => "Supplier",
      :address => "Address",
      :contact_person => "Contact Person",
      :phone => "Phone"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Supplier/)
    expect(rendered).to match(/Address/)
    expect(rendered).to match(/Contact Person/)
    expect(rendered).to match(/Phone/)
  end
end
