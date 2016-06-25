class Order < ActiveRecord::Base
  belongs_to :table
  has_many :saucerOrders
  has_many :platillos, through: :saucerOrders
  validates :status, :inclusion => {:in => [nil,1,2]}
  before_save :default_values
  def default_values
    self.status ||= 1
  end
end
