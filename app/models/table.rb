class Table < ActiveRecord::Base
    has_many :orders
    belongs_to :sucursal
    validates :name , presence:true, uniqueness:true

end
