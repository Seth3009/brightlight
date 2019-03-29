require 'rails_helper'

RSpec.describe "approvers/show", type: :view do
  before(:each) do
    @approver = assign(:approver, Approver.create!(
      :employee => nil,
      :category => "Category",
      :department => nil,
      :event => nil,
      :level => 2,
      :type => "Type",
      :notes => "Notes",
      :active => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Category/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Type/)
    expect(rendered).to match(/Notes/)
    expect(rendered).to match(/false/)
  end
end
