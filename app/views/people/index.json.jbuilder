json.array!(@people) do |person|
  json.extract! person, :id, :full_name, :first_name, :last_name, :nick_name, :date_of_birth, :place_of_birth, :gender, :passport_no, :blood_type, :mobile_phone, :home_phone, :other_phone, :email, :other_email, :bbm_pin, :wm_twitter, :sm_facebook, :sm_line, :sm_path, :sm_instagram, :sm_google_plus, :sm_linked_in, :gravatar, :photo_uri, :nationality, :religion, :address_line1, :address_line2, :kecamatan, :kabupaten, :city, :postal_code, :state, :country
  json.url person_url(person, format: :json)
end
