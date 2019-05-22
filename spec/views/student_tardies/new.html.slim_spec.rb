require 'rails_helper'

RSpec.describe "student_tardies/new", type: :view do
  before(:each) do
    assign(:student_tardy, StudentTardy.new(
      :student => nil,
      :grade => "MyString",
      :reason => "MyString",
      :employee => nil,
      :academic_year => nil
    ))
  end

  it "renders new student_tardy form" do
    render

    assert_select "form[action=?][method=?]", student_tardies_path, "post" do

      assert_select "input#student_tardy_student_id[name=?]", "student_tardy[student_id]"

      assert_select "input#student_tardy_grade[name=?]", "student_tardy[grade]"

      assert_select "input#student_tardy_reason[name=?]", "student_tardy[reason]"

      assert_select "input#student_tardy_employee_id[name=?]", "student_tardy[employee_id]"

      assert_select "input#student_tardy_academic_year_id[name=?]", "student_tardy[academic_year_id]"
    end
  end
end
