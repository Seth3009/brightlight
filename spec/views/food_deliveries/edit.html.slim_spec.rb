require 'rails_helper'

RSpec.describe "food_deliveries/edit", type: :view do
  before(:each) do
    @food_delivery = assign(:food_delivery, FoodDelivery.create!(
      :deliver_to => "MyString",
      :notes => "MyString"
    ))
  end

  it "renders the edit food_delivery form" do
    render

    assert_select "form[action=?][method=?]", food_delivery_path(@food_delivery), "post" do

      assert_select "input#food_delivery_deliver_to[name=?]", "food_delivery[deliver_to]"

      assert_select "input#food_delivery_notes[name=?]", "food_delivery[notes]"
    end
  end
end
