require 'rails_helper'

RSpec.describe "item_units/index", type: :view do
  before(:each) do
    assign(:item_units, [
      ItemUnit.create!(
        :name => "Name"
      ),
      ItemUnit.create!(
        :name => "Name"
      )
    ])
  end

  it "renders a list of item_units" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
