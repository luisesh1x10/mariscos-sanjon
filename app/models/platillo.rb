class Platillo < ActiveRecord::Base
  belongs_to :category
  has_many :saucerOrders
  has_many :orders, through: :saucerOrders
  validates_presence_of :category
  validates :price,:name,
  presence:true
end
