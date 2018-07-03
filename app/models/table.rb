class Table < ActiveRecord::Base
    has_many :orders
    belongs_to :sucursal
    

end
