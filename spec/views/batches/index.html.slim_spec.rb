require 'rails_helper'

RSpec.describe "batches/index", type: :view do
  before(:each) do
    assign(:batches, [
      Batch.create!(
        :name => "Name",
        :course => nil,
        :course_section => nil,
        :academic_year => nil,
        :academic_term => nil
      ),
      Batch.create!(
        :name => "Name",
        :course => nil,
        :course_section => nil,
        :academic_year => nil,
        :academic_term => nil
      )
    ])
  end

  it "renders a list of batches" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
