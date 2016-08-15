class Order < ActiveRecord::Base
  belongs_to :table
  belongs_to :customer
  has_many :saucerOrders
  has_many :platillos, through: :saucerOrders
  validates :status, :inclusion => {:in => [nil,1,2]}
  validates :takeaway, :inclusion => { :in => [nil,true, false] }
  before_validation  :default_values
  def default_values
    self.status ||= 1
  end

 
end
