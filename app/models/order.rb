class Order < ActiveRecord::Base
  belongs_to :tables
  has_many :saucer_orders
  has_many :platillos, through: :saucer_orders
  validates :tables_id, presence:true
end
