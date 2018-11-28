json.array!(@diknas_converted_items) do |diknas_converted_item|
  json.extract! diknas_converted_item, :id, :diknas_converted_id, :diknas_conversion_id, :P_score, :T_score, :comment
  json.url diknas_converted_item_url(diknas_converted_item, format: :json)
end
