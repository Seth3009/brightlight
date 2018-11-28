json.array!(@diknas_report_converted_items) do |diknas_report_converted_item|
  json.extract! diknas_report_converted_item, :id, :diknas_report_converted_id, :diknas_conversion_id, :P_score, :T_score, :comment
  json.url diknas_report_converted_item_url(diknas_report_converted_item, format: :json)
end
