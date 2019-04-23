require 'rails_helper'

RSpec.describe "approvers/index", type: :view do
  before(:each) do
    assign(:approvers, [
      Approver.create!(
        :employee => nil,
        :category => "Category",
        :department => nil,
        :event => nil,
        :level => 2,
        :type => "Type",
        :notes => "Notes",
        :active => false
      ),
      Approver.create!(
        :employee => nil,
        :category => "Category",
        :department => nil,
        :event => nil,
        :level => 2,
        :type => "Type",
        :notes => "Notes",
        :active => false
      )
    ])
  end

  it "renders a list of approvers" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Category".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Type".to_s, :count => 2
    assert_select "tr>td", :text => "Notes".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
