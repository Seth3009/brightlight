json.array!(@messages) do |message|
  json.extract! message, :id, :subject, :creator_id, :body, :parent_id, :expiry_date, :is_reminder, :next_remind_date, :tags, :msg_folder_id
  json.url message_url(message, format: :json)
end
