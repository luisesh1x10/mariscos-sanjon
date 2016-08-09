json.extract! customer, :id, :nombre, :telefono, :calle, :colonia, :numero_interior, :numero_exterior, :created_at, :updated_at
json.url customer_url(customer, format: :json)