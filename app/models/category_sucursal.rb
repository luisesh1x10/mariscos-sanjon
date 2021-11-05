class CategorySucursal < ActiveRecord::Base
  belongs_to :category
  belongs_to :sucursal
end
