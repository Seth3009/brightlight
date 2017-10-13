require 'rails_helper'

RSpec.describe "budgets/new", type: :view do
  before(:each) do
    assign(:budget, Budget.new(
<<<<<<< HEAD
      :department => "",
      :grade_level => "",
      :grade_section => "",
      :budget_holder => "",
      :academic_year => "",
      :is_submitted => "",
      :submit_date => "",
      :is_approved => "",
      :approved_date => "",
      :approver => "",
      :is_received => "",
      :receiver => "",
      :received_date => "",
      :total_amt => "",
      :notes, => "MyString",
      :category, => "MyString",
      :type, => "MyString",
      :group, => "MyString",
      :version, => "MyString"
=======
      :department => nil,
      :owner => nil,
      :grade_level => nil,
      :grade_section => nil,
      :academic_year => nil,
      :submitted => false,
      :approved => false,
      :approver => nil,
      :type => "",
      :category => "MyString",
      :active => false,
      :notes => "MyString"
>>>>>>> cd6c4ee8f66d6b981d7fad34ac79bf7ca894e43d
    ))
  end

  it "renders new budget form" do
    render

    assert_select "form[action=?][method=?]", budgets_path, "post" do

<<<<<<< HEAD
      assert_select "input#budget_department[name=?]", "budget[department]"

      assert_select "input#budget_grade_level[name=?]", "budget[grade_level]"

      assert_select "input#budget_grade_section[name=?]", "budget[grade_section]"

      assert_select "input#budget_budget_holder[name=?]", "budget[budget_holder]"

      assert_select "input#budget_academic_year[name=?]", "budget[academic_year]"

      assert_select "input#budget_is_submitted[name=?]", "budget[is_submitted]"

      assert_select "input#budget_submit_date[name=?]", "budget[submit_date]"

      assert_select "input#budget_is_approved[name=?]", "budget[is_approved]"

      assert_select "input#budget_approved_date[name=?]", "budget[approved_date]"

      assert_select "input#budget_approver[name=?]", "budget[approver]"

      assert_select "input#budget_is_received[name=?]", "budget[is_received]"

      assert_select "input#budget_receiver[name=?]", "budget[receiver]"

      assert_select "input#budget_received_date[name=?]", "budget[received_date]"

      assert_select "input#budget_total_amt[name=?]", "budget[total_amt]"

      assert_select "input#budget_notes,[name=?]", "budget[notes,]"

      assert_select "input#budget_category,[name=?]", "budget[category,]"

      assert_select "input#budget_type,[name=?]", "budget[type,]"

      assert_select "input#budget_group,[name=?]", "budget[group,]"

      assert_select "input#budget_version,[name=?]", "budget[version,]"
=======
      assert_select "input#budget_department_id[name=?]", "budget[department_id]"

      assert_select "input#budget_owner_id[name=?]", "budget[owner_id]"

      assert_select "input#budget_grade_level_id[name=?]", "budget[grade_level_id]"

      assert_select "input#budget_grade_section_id[name=?]", "budget[grade_section_id]"

      assert_select "input#budget_academic_year_id[name=?]", "budget[academic_year_id]"

      assert_select "input#budget_submitted[name=?]", "budget[submitted]"

      assert_select "input#budget_approved[name=?]", "budget[approved]"

      assert_select "input#budget_approver_id[name=?]", "budget[approver_id]"

      assert_select "input#budget_type[name=?]", "budget[type]"

      assert_select "input#budget_category[name=?]", "budget[category]"

      assert_select "input#budget_active[name=?]", "budget[active]"

      assert_select "input#budget_notes[name=?]", "budget[notes]"
>>>>>>> cd6c4ee8f66d6b981d7fad34ac79bf7ca894e43d
    end
  end
end
