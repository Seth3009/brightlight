require 'rails_helper'

RSpec.describe "nat_exams/edit", type: :view do
  before(:each) do
    @nat_exam = assign(:nat_exam, NatExam.create!(
      :student => nil,
      :grade_level => nil,
      :academic_year => nil,
      :diknas_course => nil,
      :try_out_1 => 1.5,
      :try_out_2 => 1.5,
      :try_out_3 => 1.5,
      :ujian_sekolah => 1.5,
      :nilai_sekolah => 1.5,
      :ujian_nasional => 1.5
    ))
  end

  it "renders the edit nat_exam form" do
    render

    assert_select "form[action=?][method=?]", nat_exam_path(@nat_exam), "post" do

      assert_select "input#nat_exam_student_id[name=?]", "nat_exam[student_id]"

      assert_select "input#nat_exam_grade_level_id[name=?]", "nat_exam[grade_level_id]"

      assert_select "input#nat_exam_academic_year_id[name=?]", "nat_exam[academic_year_id]"

      assert_select "input#nat_exam_diknas_course_id[name=?]", "nat_exam[diknas_course_id]"

      assert_select "input#nat_exam_try_out_1[name=?]", "nat_exam[try_out_1]"

      assert_select "input#nat_exam_try_out_2[name=?]", "nat_exam[try_out_2]"

      assert_select "input#nat_exam_try_out_3[name=?]", "nat_exam[try_out_3]"

      assert_select "input#nat_exam_ujian_sekolah[name=?]", "nat_exam[ujian_sekolah]"

      assert_select "input#nat_exam_nilai_sekolah[name=?]", "nat_exam[nilai_sekolah]"

      assert_select "input#nat_exam_ujian_nasional[name=?]", "nat_exam[ujian_nasional]"
    end
  end
end
