require 'rails_helper'

RSpec.describe "class_periods/edit", type: :view do
  before(:each) do
    @class_period = assign(:class_period, ClassPeriod.create!(
      :name => "MyString",
      :school => "MyString",
      :is_break => "MyString"
    ))
  end

  it "renders the edit class_period form" do
    render

    assert_select "form[action=?][method=?]", class_period_path(@class_period), "post" do

      assert_select "input#class_period_name[name=?]", "class_period[name]"

      assert_select "input#class_period_school[name=?]", "class_period[school]"

      assert_select "input#class_period_is_break[name=?]", "class_period[is_break]"
    end
  end
end
