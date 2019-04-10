require 'rails_helper'

RSpec.describe "lunch_menus/edit", type: :view do
  before(:each) do
    @lunch_menu = assign(:lunch_menu, LunchMenu.create!(
      :food => nil,
      :adj_g1 => 1,
      :adj_g4 => 1,
      :adj_sol => 1,
      :adj_sor => 1,
      :adj_adult => 1,
      :total_adj => 1,
      :academic_year => nil
    ))
  end

  it "renders the edit lunch_menu form" do
    render

    assert_select "form[action=?][method=?]", lunch_menu_path(@lunch_menu), "post" do

      assert_select "input#lunch_menu_food_id[name=?]", "lunch_menu[food_id]"

      assert_select "input#lunch_menu_adj_g1[name=?]", "lunch_menu[adj_g1]"

      assert_select "input#lunch_menu_adj_g4[name=?]", "lunch_menu[adj_g4]"

      assert_select "input#lunch_menu_adj_sol[name=?]", "lunch_menu[adj_sol]"

      assert_select "input#lunch_menu_adj_sor[name=?]", "lunch_menu[adj_sor]"

      assert_select "input#lunch_menu_adj_adult[name=?]", "lunch_menu[adj_adult]"

      assert_select "input#lunch_menu_total_adj[name=?]", "lunch_menu[total_adj]"

      assert_select "input#lunch_menu_academic_year_id[name=?]", "lunch_menu[academic_year_id]"
    end
  end
end
