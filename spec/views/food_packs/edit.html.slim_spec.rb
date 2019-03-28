require 'rails_helper'

RSpec.describe "food_packs/edit", type: :view do
  before(:each) do
    @food_pack = assign(:food_pack, FoodPack.create!(
      :g1 => 1,
      :g2 => 1,
      :g3 => 1,
      :g4 => 1,
      :g5 => 1,
      :g6 => 1,
      :g7 => 1,
      :g8 => 1,
      :g9 => 1,
      :g10 => 1,
      :g11 => 1,
      :g12 => 1,
      :employee => 1,
      :academic_year => nil
    ))
  end

  it "renders the edit food_pack form" do
    render

    assert_select "form[action=?][method=?]", food_pack_path(@food_pack), "post" do

      assert_select "input#food_pack_g1[name=?]", "food_pack[g1]"

      assert_select "input#food_pack_g2[name=?]", "food_pack[g2]"

      assert_select "input#food_pack_g3[name=?]", "food_pack[g3]"

      assert_select "input#food_pack_g4[name=?]", "food_pack[g4]"

      assert_select "input#food_pack_g5[name=?]", "food_pack[g5]"

      assert_select "input#food_pack_g6[name=?]", "food_pack[g6]"

      assert_select "input#food_pack_g7[name=?]", "food_pack[g7]"

      assert_select "input#food_pack_g8[name=?]", "food_pack[g8]"

      assert_select "input#food_pack_g9[name=?]", "food_pack[g9]"

      assert_select "input#food_pack_g10[name=?]", "food_pack[g10]"

      assert_select "input#food_pack_g11[name=?]", "food_pack[g11]"

      assert_select "input#food_pack_g12[name=?]", "food_pack[g12]"

      assert_select "input#food_pack_employee[name=?]", "food_pack[employee]"

      assert_select "input#food_pack_academic_year_id[name=?]", "food_pack[academic_year_id]"
    end
  end
end
