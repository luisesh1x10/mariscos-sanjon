class Expense < ActiveRecord::Base
    belongs_to :sucursal
    validates :category, :amount, :description, presence:true
end
