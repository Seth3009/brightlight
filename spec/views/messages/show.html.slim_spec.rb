require 'rails_helper'

RSpec.describe "messages/show", type: :view do
  before(:each) do
    @message = assign(:message, Message.create!(
      :subject => "Subject",
      :creator => nil,
      :body => "Body",
      :parent => nil,
      :is_reminder => false,
      :remind_frequency => nil,
      :tags => "Tags",
      :folder => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Subject/)
    expect(rendered).to match(//)
    expect(rendered).to match(/Body/)
    expect(rendered).to match(//)
    expect(rendered).to match(/false/)
    expect(rendered).to match(//)
    expect(rendered).to match(/Tags/)
    expect(rendered).to match(//)
  end
end
