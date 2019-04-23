json.array!(@approvers) do |approver|
  json.extract! approver, :id, :employee_id, :category, :department_id, :event_id, :start_date, :end_date, :level, :type, :notes, :active
  json.url approver_url(approver, format: :json)
end
