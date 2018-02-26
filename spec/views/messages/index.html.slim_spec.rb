require 'rails_helper'

RSpec.describe "messages/index", type: :view do
  before(:each) do
    assign(:messages, [
      Message.create!(
        :subject => "Subject",
        :creator => nil,
        :body => "Body",
        :parent => nil,
        :is_reminder => false,
        :remind_frequency => nil,
        :tags => "Tags",
        :folder => nil
      ),
      Message.create!(
        :subject => "Subject",
        :creator => nil,
        :body => "Body",
        :parent => nil,
        :is_reminder => false,
        :remind_frequency => nil,
        :tags => "Tags",
        :folder => nil
      )
    ])
  end

  it "renders a list of messages" do
    render
    assert_select "tr>td", :text => "Subject".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Body".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Tags".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
