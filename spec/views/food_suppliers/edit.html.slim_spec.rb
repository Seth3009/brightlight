require 'rails_helper'

RSpec.describe "food_suppliers/edit", type: :view do
  before(:each) do
    @food_supplier = assign(:food_supplier, FoodSupplier.create!(
      :supplier => "MyString",
      :address => "MyString",
      :contact_person => "MyString",
      :phone => "MyString"
    ))
  end

  it "renders the edit food_supplier form" do
    render

    assert_select "form[action=?][method=?]", food_supplier_path(@food_supplier), "post" do

      assert_select "input#food_supplier_supplier[name=?]", "food_supplier[supplier]"

      assert_select "input#food_supplier_address[name=?]", "food_supplier[address]"

      assert_select "input#food_supplier_contact_person[name=?]", "food_supplier[contact_person]"

      assert_select "input#food_supplier_phone[name=?]", "food_supplier[phone]"
    end
  end
end
