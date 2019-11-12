json.extract! requet, :id, :sucursal_id, :status, :anotaciones, :created_at, :updated_at
json.url requet_url(requet, format: :json)