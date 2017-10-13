require 'rails_helper'

RSpec.describe "deliveries/index", type: :view do
  before(:each) do
    assign(:deliveries, [
      Delivery.create!(
        :purchase_order => "",
        :delivery_date => "",
        :address, => "Address,",
        :accepted_by => "",
        :accepted_date => "",
        :checked_by => "",
        :checked_date => "",
        :notes, => "Notes,",
        :method, => "Method,",
        :status => "Status"
      ),
      Delivery.create!(
        :purchase_order => "",
        :delivery_date => "",
        :address, => "Address,",
        :accepted_by => "",
        :accepted_date => "",
        :checked_by => "",
        :checked_date => "",
        :notes, => "Notes,",
        :method, => "Method,",
        :status => "Status"
      )
    ])
  end

  it "renders a list of deliveries" do
    render
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Address,".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Notes,".to_s, :count => 2
    assert_select "tr>td", :text => "Method,".to_s, :count => 2
    assert_select "tr>td", :text => "Status".to_s, :count => 2
  end
end
