json.array!(@ingredients) do |ingredient|
  json.extract! ingredient, :id, :name, :stock, :measurement_unit_id
  json.url ingredient_url(ingredient, format: :json)
end
