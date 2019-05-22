require 'rails_helper'

RSpec.describe "student_tardies/show", type: :view do
  before(:each) do
    @student_tardy = assign(:student_tardy, StudentTardy.create!(
      :student => nil,
      :grade => "Grade",
      :reason => "Reason",
      :employee => nil,
      :academic_year => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Grade/)
    expect(rendered).to match(/Reason/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
