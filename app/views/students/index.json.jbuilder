json.array!(@students) do |student|
  json.extract! student, :id, :name, :first_name, :last_name, :date_of_birth, :admission_no, :family_id, :gender, :blood_type, :nationality, :religion, :address_line1, :address_line2, :city, :state, :postal_code, :country, :mobile_phone, :home_phone, :email, :photo_uri, :status, :status_description, :is_active, :is_deleted, :student_no, :passport_no, :enrollment_date
  json.url student_url(student, format: :json)
end
