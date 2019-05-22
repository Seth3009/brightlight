json.array!(@course_sections) do |course_section|
  json.extract! course_section, :id, :name, :instructor_id, :instructor2_id, :aide_id, :location_id
end
