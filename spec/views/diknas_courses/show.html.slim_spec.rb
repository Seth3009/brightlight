require 'rails_helper'

RSpec.describe "diknas_courses/show", type: :view do
  before(:each) do
    @diknas_course = assign(:diknas_course, DiknasCourse.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
