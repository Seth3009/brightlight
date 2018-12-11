require 'rails_helper'

RSpec.describe "diknas_courses/edit", type: :view do
  before(:each) do
    @diknas_course = assign(:diknas_course, DiknasCourse.create!())
  end

  it "renders the edit diknas_course form" do
    render

    assert_select "form[action=?][method=?]", diknas_course_path(@diknas_course), "post" do
    end
  end
end
