json.array!(@leave_requests) do |leave_request|
  json.extract! leave_request, :id, :start_date, :end_date, :hour, :leave_type, :leave_note, :leave_subtitute, :subtitute_notes, :spv_approval, :spv_date, :spv_notes, :hr_approval, :hr_date, :hr_notes, :form_submit_date, :leave_attachment, :employee_id
  json.url leave_request_url(leave_request, format: :json)
end
