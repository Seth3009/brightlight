require 'rails_helper'

RSpec.describe "student_tardies/index", type: :view do
  before(:each) do
    assign(:student_tardies, [
      StudentTardy.create!(
        :student => nil,
        :grade => "Grade",
        :reason => "Reason",
        :employee => nil,
        :academic_year => nil
      ),
      StudentTardy.create!(
        :student => nil,
        :grade => "Grade",
        :reason => "Reason",
        :employee => nil,
        :academic_year => nil
      )
    ])
  end

  it "renders a list of student_tardies" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Grade".to_s, :count => 2
    assert_select "tr>td", :text => "Reason".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
