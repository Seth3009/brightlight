require 'rails_helper'

RSpec.describe "diknas_conversion_items/show", type: :view do
  before(:each) do
    @diknas_conversion_item = assign(:diknas_conversion_item, DiknasConversionItem.create!(
      :diknas_conversion => nil,
      :course => nil,
      :academic_year => nil,
      :academic_term => nil,
      :weight => 2,
      :notes => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/MyText/)
  end
end
