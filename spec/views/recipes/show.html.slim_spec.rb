require 'rails_helper'

RSpec.describe "recipes/show", type: :view do
  before(:each) do
    @recipe = assign(:recipe, Recipe.create!(
      :food => nil,
      :raw_food => nil,
      :recipe_portion => 2,
      :qty => 3.5,
      :custom_size => 4.5,
      :size_divider => 5.5,
      :portion_size => 6.5,
      :gr1_portion => 7.5,
      :gr2_portion => 8.5,
      :sol_portion => 9.5,
      :sor_portion => 10.5,
      :adult_portion => 11.5
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3.5/)
    expect(rendered).to match(/4.5/)
    expect(rendered).to match(/5.5/)
    expect(rendered).to match(/6.5/)
    expect(rendered).to match(/7.5/)
    expect(rendered).to match(/8.5/)
    expect(rendered).to match(/9.5/)
    expect(rendered).to match(/10.5/)
    expect(rendered).to match(/11.5/)
  end
end
