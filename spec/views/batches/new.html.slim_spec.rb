require 'rails_helper'

RSpec.describe "batches/new", type: :view do
  before(:each) do
    assign(:batch, Batch.new(
      :name => "MyString",
      :course => nil,
      :course_section => nil,
      :academic_year => nil,
      :academic_term => nil
    ))
  end

  it "renders new batch form" do
    render

    assert_select "form[action=?][method=?]", batches_path, "post" do

      assert_select "input#batch_name[name=?]", "batch[name]"

      assert_select "input#batch_course_id[name=?]", "batch[course_id]"

      assert_select "input#batch_course_section_id[name=?]", "batch[course_section_id]"

      assert_select "input#batch_academic_year_id[name=?]", "batch[academic_year_id]"

      assert_select "input#batch_academic_term_id[name=?]", "batch[academic_term_id]"
    end
  end
end
