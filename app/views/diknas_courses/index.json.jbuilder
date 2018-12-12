json.array!(@diknas_courses) do |diknas_course|
  json.extract! diknas_course, :id
  json.url diknas_course_url(diknas_course, format: :json)
end
