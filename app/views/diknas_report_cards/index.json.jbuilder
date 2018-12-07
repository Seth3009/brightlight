json.array!(@diknas_report_cards) do |diknas_report_card|
  json.extract! diknas_report_card, :id, :student_id, :grade_level_id, :grade_section_id, :academic_year_id, :academic_term_id, :course_belongs_to, :average, :notes
  json.url diknas_report_card_url(diknas_report_card, format: :json)
end
