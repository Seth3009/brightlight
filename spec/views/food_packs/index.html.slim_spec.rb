require 'rails_helper'

RSpec.describe "food_packs/index", type: :view do
  before(:each) do
    assign(:food_packs, [
      FoodPack.create!(
        :g1 => 2,
        :g2 => 3,
        :g3 => 4,
        :g4 => 5,
        :g5 => 6,
        :g6 => 7,
        :g7 => 8,
        :g8 => 9,
        :g9 => 10,
        :g10 => 11,
        :g11 => 12,
        :g12 => 13,
        :employee => 14,
        :academic_year => nil
      ),
      FoodPack.create!(
        :g1 => 2,
        :g2 => 3,
        :g3 => 4,
        :g4 => 5,
        :g5 => 6,
        :g6 => 7,
        :g7 => 8,
        :g8 => 9,
        :g9 => 10,
        :g10 => 11,
        :g11 => 12,
        :g12 => 13,
        :employee => 14,
        :academic_year => nil
      )
    ])
  end

  it "renders a list of food_packs" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => 6.to_s, :count => 2
    assert_select "tr>td", :text => 7.to_s, :count => 2
    assert_select "tr>td", :text => 8.to_s, :count => 2
    assert_select "tr>td", :text => 9.to_s, :count => 2
    assert_select "tr>td", :text => 10.to_s, :count => 2
    assert_select "tr>td", :text => 11.to_s, :count => 2
    assert_select "tr>td", :text => 12.to_s, :count => 2
    assert_select "tr>td", :text => 13.to_s, :count => 2
    assert_select "tr>td", :text => 14.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
