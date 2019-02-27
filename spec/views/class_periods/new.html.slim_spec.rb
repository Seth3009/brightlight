require 'rails_helper'

RSpec.describe "class_periods/new", type: :view do
  before(:each) do
    assign(:class_period, ClassPeriod.new(
      :name => "MyString",
      :school => "MyString",
      :is_break => "MyString"
    ))
  end

  it "renders new class_period form" do
    render

    assert_select "form[action=?][method=?]", class_periods_path, "post" do

      assert_select "input#class_period_name[name=?]", "class_period[name]"

      assert_select "input#class_period_school[name=?]", "class_period[school]"

      assert_select "input#class_period_is_break[name=?]", "class_period[is_break]"
    end
  end
end
