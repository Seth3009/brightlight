require 'rails_helper'

RSpec.describe "stock_categories/show", type: :view do
  before(:each) do
    @stock_category = assign(:stock_category, StockCategory.create!(
      :name, => "Name,",
      :code, => "Code,",
      :description, => "Description,",
      :type, => "Type,",
      :is_active => "",
      :location => "Location"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name,/)
    expect(rendered).to match(/Code,/)
    expect(rendered).to match(/Description,/)
    expect(rendered).to match(/Type,/)
    expect(rendered).to match(//)
    expect(rendered).to match(/Location/)
  end
end
