require 'rails_helper'

RSpec.describe "diknas_courses/index", type: :view do
  before(:each) do
    assign(:diknas_courses, [
      DiknasCourse.create!(),
      DiknasCourse.create!()
    ])
  end

  it "renders a list of diknas_courses" do
    render
  end
end
