if params[:short]
  json.extract! @employee, :id, :name
else
  json.extract! @employee, :id, :name, :first_name, :last_name, :gender, :date_of_birth, :place_of_birth, :joining_date, :job_title, :employee_number, :marital_status, :experience_year, :experience_month, :employment_status, :children_count, :home_address_line1, :home_address_line2, :home_city, :home_state, :home_country, :home_postal_code, :mobile_phone, :home_phone, :office_phone, :other_phone, :emergency_contact_number, :emergency_contact_name, :email, :photo_uri, :education_degree, :education_graduation_date, :education_school, :education_degree2, :education_graduation_date2, :education_school2, :department_id, :nationality, :blood_type, :created_at, :updated_at
end