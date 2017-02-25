json.array!(@expenses) do |expense|
  json.extract! expense, :id, :amount, :category, :description, :quantity, :ingredient_id
  json.url expense_url(expense, format: :json)
end
