json.extract! input, :id, :resource_id, :cantidad, :precio, :created_at, :updated_at
json.url input_url(input, format: :json)