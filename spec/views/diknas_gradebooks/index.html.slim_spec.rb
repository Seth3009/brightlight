require 'rails_helper'

RSpec.describe "diknas_gradebooks/index", type: :view do
  before(:each) do
    assign(:diknas_gradebooks, [
      DiknasGradebook.create!(
        :studentname => "Studentname",
        :grade => "Grade",
        :class => "Class",
        :avg => "Avg",
        :semester => "Semester"
      ),
      DiknasGradebook.create!(
        :studentname => "Studentname",
        :grade => "Grade",
        :class => "Class",
        :avg => "Avg",
        :semester => "Semester"
      )
    ])
  end

  it "renders a list of diknas_gradebooks" do
    render
    assert_select "tr>td", :text => "Studentname".to_s, :count => 2
    assert_select "tr>td", :text => "Grade".to_s, :count => 2
    assert_select "tr>td", :text => "Class".to_s, :count => 2
    assert_select "tr>td", :text => "Avg".to_s, :count => 2
    assert_select "tr>td", :text => "Semester".to_s, :count => 2
  end
end
