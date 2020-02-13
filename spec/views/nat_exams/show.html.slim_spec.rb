require 'rails_helper'

RSpec.describe "nat_exams/show", type: :view do
  before(:each) do
    @nat_exam = assign(:nat_exam, NatExam.create!(
      :student => nil,
      :grade_level => nil,
      :academic_year => nil,
      :diknas_course => nil,
      :try_out_1 => 2.5,
      :try_out_2 => 3.5,
      :try_out_3 => 4.5,
      :ujian_sekolah => 5.5,
      :nilai_sekolah => 6.5,
      :ujian_nasional => 7.5
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/2.5/)
    expect(rendered).to match(/3.5/)
    expect(rendered).to match(/4.5/)
    expect(rendered).to match(/5.5/)
    expect(rendered).to match(/6.5/)
    expect(rendered).to match(/7.5/)
  end
end
