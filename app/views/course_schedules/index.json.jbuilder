json.array!(@course_schedules) do |course_schedule|
  json.extract! course_schedule, :id, :course_id, :course_section_id, :class_period_id, :room_id, :active, :academic_term_id
  json.url course_schedule_url(course_schedule, format: :json)
end
