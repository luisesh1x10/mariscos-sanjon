class SaucerOrder < ActiveRecord::Base
  belongs_to :platillo
  belongs_to :order
  
  validates_presence_of :platillo
  validates_presence_of :order
  validates :platillo_id,
  :order_id,
  presence:true
  validates :status, :inclusion => {:in => [nil,1,2,3,4]}
  before_save :default_values
  def default_values
    self.status ||= 1
  end
end


=begin
  status{
    1-->por hacer
    2-->en processo
    3--> terminado
    4--> entregado
  }
=end