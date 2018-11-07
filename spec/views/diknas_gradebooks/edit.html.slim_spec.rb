require 'rails_helper'

RSpec.describe "diknas_gradebooks/edit", type: :view do
  before(:each) do
    @diknas_gradebook = assign(:diknas_gradebook, DiknasGradebook.create!(
      :studentname => "MyString",
      :grade => "MyString",
      :class => "MyString",
      :avg => "MyString",
      :semester => "MyString"
    ))
  end

  it "renders the edit diknas_gradebook form" do
    render

    assert_select "form[action=?][method=?]", diknas_gradebook_path(@diknas_gradebook), "post" do

      assert_select "input#diknas_gradebook_studentname[name=?]", "diknas_gradebook[studentname]"

      assert_select "input#diknas_gradebook_grade[name=?]", "diknas_gradebook[grade]"

      assert_select "input#diknas_gradebook_class[name=?]", "diknas_gradebook[class]"

      assert_select "input#diknas_gradebook_avg[name=?]", "diknas_gradebook[avg]"

      assert_select "input#diknas_gradebook_semester[name=?]", "diknas_gradebook[semester]"
    end
  end
end
