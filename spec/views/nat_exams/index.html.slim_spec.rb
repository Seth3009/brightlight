require 'rails_helper'

RSpec.describe "nat_exams/index", type: :view do
  before(:each) do
    assign(:nat_exams, [
      NatExam.create!(
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
      ),
      NatExam.create!(
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
      )
    ])
  end

  it "renders a list of nat_exams" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 2.5.to_s, :count => 2
    assert_select "tr>td", :text => 3.5.to_s, :count => 2
    assert_select "tr>td", :text => 4.5.to_s, :count => 2
    assert_select "tr>td", :text => 5.5.to_s, :count => 2
    assert_select "tr>td", :text => 6.5.to_s, :count => 2
    assert_select "tr>td", :text => 7.5.to_s, :count => 2
  end
end
