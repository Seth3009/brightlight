require 'rails_helper'

RSpec.describe "diknas_converted_items/show", type: :view do
  before(:each) do
    @diknas_converted_item = assign(:diknas_converted_item, DiknasConvertedItem.create!(
      :diknas_converted => nil,
      :diknas_conversion => nil,
      :p_score => 2.5,
      :t_score => 3.5,
      :comment => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/2.5/)
    expect(rendered).to match(/3.5/)
    expect(rendered).to match(/MyText/)
  end
end
