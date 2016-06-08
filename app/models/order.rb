class Order < ActiveRecord::Base
  belongs_to :table
  has_many :saucerOrders
  has_many :platillos, through: :saucerOrders
  validates :table_id, presence:true
end
