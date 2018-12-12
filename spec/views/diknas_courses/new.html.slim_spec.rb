require 'rails_helper'

RSpec.describe "diknas_courses/new", type: :view do
  before(:each) do
    assign(:diknas_course, DiknasCourse.new())
  end

  it "renders new diknas_course form" do
    render

    assert_select "form[action=?][method=?]", diknas_courses_path, "post" do
    end
  end
end
