require 'rails_helper'

RSpec.describe "lunch_menus/index", type: :view do
  before(:each) do
    assign(:lunch_menus, [
      LunchMenu.create!(
        :food => nil,
        :adj_g1 => 2,
        :adj_g4 => 3,
        :adj_sol => 4,
        :adj_sor => 5,
        :adj_adult => 6,
        :total_adj => 7,
        :academic_year => nil
      ),
      LunchMenu.create!(
        :food => nil,
        :adj_g1 => 2,
        :adj_g4 => 3,
        :adj_sol => 4,
        :adj_sor => 5,
        :adj_adult => 6,
        :total_adj => 7,
        :academic_year => nil
      )
    ])
  end

  it "renders a list of lunch_menus" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => 6.to_s, :count => 2
    assert_select "tr>td", :text => 7.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
