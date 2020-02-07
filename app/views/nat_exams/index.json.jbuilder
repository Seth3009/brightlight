json.array!(@nat_exams) do |nat_exam|
  json.extract! nat_exam, :id, :student_id, :grade_level_id, :academic_year_id, :diknas_course_id, :try_out_1, :try_out_2, :try_out_3, :ujian_sekolah, :nilai_sekolah, :ujian_nasional
  json.url nat_exam_url(nat_exam, format: :json)
end
