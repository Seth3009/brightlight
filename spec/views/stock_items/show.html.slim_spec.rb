require 'rails_helper'

RSpec.describe "stock_items/show", type: :view do
  before(:each) do
    @stock_item = assign(:stock_item, StockItem.create!(
      :name, => "Name,",
      :code, => "Code,",
      :description, => "Description,",
      :tags, => "Tags,",
      :short_desc, => "Short Desc,",
      :is_active => "",
      :unit_price => "",
      :image => "",
      :stock_category => "",
      :class, => "Class,",
      :group, => "Group,",
      :weight, => "Weight,",
      :extra1, => "Extra1,",
      :extra2 => "Extra2"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name,/)
    expect(rendered).to match(/Code,/)
    expect(rendered).to match(/Description,/)
    expect(rendered).to match(/Tags,/)
    expect(rendered).to match(/Short Desc,/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/Class,/)
    expect(rendered).to match(/Group,/)
    expect(rendered).to match(/Weight,/)
    expect(rendered).to match(/Extra1,/)
    expect(rendered).to match(/Extra2/)
  end
end
