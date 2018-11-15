require 'rails_helper'

RSpec.describe "diknas_conversions/show", type: :view do
  before(:each) do
    @diknas_conversion = assign(:diknas_conversion, DiknasConversion.create!(
      :course => nil,
      :diknas_course => nil,
      :academic_year => nil,
      :academic_term => nil,
      :weight => 2.5,
      :notes => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/2.5/)
    expect(rendered).to match(/MyText/)
  end
end
