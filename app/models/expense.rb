class Expense < ActiveRecord::Base
    validates :category, :amount, :description, presence:true
end
