require 'rails_helper'

RSpec.describe "diknas_gradebooks/show", type: :view do
  before(:each) do
    @diknas_gradebook = assign(:diknas_gradebook, DiknasGradebook.create!(
      :studentname => "Studentname",
      :grade => "Grade",
      :class => "Class",
      :avg => "Avg",
      :semester => "Semester"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Studentname/)
    expect(rendered).to match(/Grade/)
    expect(rendered).to match(/Class/)
    expect(rendered).to match(/Avg/)
    expect(rendered).to match(/Semester/)
  end
end
