require 'rails_helper'

RSpec.describe "food_packs/show", type: :view do
  before(:each) do
    @food_pack = assign(:food_pack, FoodPack.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/5/)
    expect(rendered).to match(/6/)
    expect(rendered).to match(/7/)
    expect(rendered).to match(/8/)
    expect(rendered).to match(/9/)
    expect(rendered).to match(/10/)
    expect(rendered).to match(/11/)
    expect(rendered).to match(/12/)
    expect(rendered).to match(/13/)
    expect(rendered).to match(/14/)
    expect(rendered).to match(//)
  end
end
