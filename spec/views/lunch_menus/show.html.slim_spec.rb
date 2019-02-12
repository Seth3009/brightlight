require 'rails_helper'

RSpec.describe "lunch_menus/show", type: :view do
  before(:each) do
    @lunch_menu = assign(:lunch_menu, LunchMenu.create!(
      :food => nil,
      :adj_g1 => 2,
      :adj_g4 => 3,
      :adj_sol => 4,
      :adj_sor => 5,
      :adj_adult => 6,
      :total_adj => 7,
      :academic_year => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/5/)
    expect(rendered).to match(/6/)
    expect(rendered).to match(/7/)
    expect(rendered).to match(//)
  end
end
