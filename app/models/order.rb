class Order < ActiveRecord::Base
  belongs_to :table
  has_many :saucerOrders
  has_many :platillos, through: :saucerOrder
  validates :tables_id, presence:true
end
