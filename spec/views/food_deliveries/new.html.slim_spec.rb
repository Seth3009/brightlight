require 'rails_helper'

RSpec.describe "food_deliveries/new", type: :view do
  before(:each) do
    assign(:food_delivery, FoodDelivery.new(
      :deliver_to => "MyString",
      :notes => "MyString"
    ))
  end

  it "renders new food_delivery form" do
    render

    assert_select "form[action=?][method=?]", food_deliveries_path, "post" do

      assert_select "input#food_delivery_deliver_to[name=?]", "food_delivery[deliver_to]"

      assert_select "input#food_delivery_notes[name=?]", "food_delivery[notes]"
    end
  end
end
