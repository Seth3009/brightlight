require 'rails_helper'

RSpec.describe "deliveries/edit", type: :view do
  before(:each) do
    @delivery = assign(:delivery, Delivery.create!(
      :purchase_order => "",
      :delivery_date => "",
      :address, => "MyString",
      :accepted_by => "",
      :accepted_date => "",
      :checked_by => "",
      :checked_date => "",
      :notes, => "MyString",
      :method, => "MyString",
      :status => "MyString"
    ))
  end

  it "renders the edit delivery form" do
    render

    assert_select "form[action=?][method=?]", delivery_path(@delivery), "post" do

      assert_select "input#delivery_purchase_order[name=?]", "delivery[purchase_order]"

      assert_select "input#delivery_delivery_date[name=?]", "delivery[delivery_date]"

      assert_select "input#delivery_address,[name=?]", "delivery[address,]"

      assert_select "input#delivery_accepted_by[name=?]", "delivery[accepted_by]"

      assert_select "input#delivery_accepted_date[name=?]", "delivery[accepted_date]"

      assert_select "input#delivery_checked_by[name=?]", "delivery[checked_by]"

      assert_select "input#delivery_checked_date[name=?]", "delivery[checked_date]"

      assert_select "input#delivery_notes,[name=?]", "delivery[notes,]"

      assert_select "input#delivery_method,[name=?]", "delivery[method,]"

      assert_select "input#delivery_status[name=?]", "delivery[status]"
    end
  end
end
