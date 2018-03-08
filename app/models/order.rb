class Order < ActiveRecord::Base
  belongs_to :table
  belongs_to :customer
  has_many :saucerOrders
  has_many :platillos, through: :saucerOrders
  has_many :users, through: :saucerOrders
  validates :status, :inclusion => {:in => [nil,1,2]}
  validates :takeaway, :inclusion => { :in => [nil,true, false] }
  before_validation  :default_values
  def default_values
    self.status ||= 1
  end
  
  attr_accessor :total,:pedidos
  
  def total
    self.saucerOrders.sum('price*quantity')
  end
  def descuentoTotal
    self.saucerOrders.sum('(price*quantity)*(discount/100)')
  end
  def ivaTotal
    if (self.saucerOrders.count > 0 )
      self.saucerOrders.sum('(price*quantity) - (price*quantity)*(discount/100)') * (self.saucerOrders.first.iva.to_f / 100.to_f)
    else
      0
    end 
  end
  def totalConDescuento
    total-descuentoTotal
  end
  def totalConDescuentoYIva
    total-descuentoTotal+ivaTotal
  end
  
  def pedidos
    self.saucerOrders.count
  end
  def mesero 
    return "desconocido" if  self.saucerOrders.count==0 or self.saucerOrders.first.user.nil?
    ac = []
    self.users.uniq.each do |u|
      ac << u.name
    end
    ac.join(", ")
  end
  def regulador(limite)
    lista = []
    valor = 0
    self.saucerOrders.each do |so|
      if valor < limite
        lista << so
      end
      valor = valor + so.price * so.quantity
    end
    lista
  end
  def regulador_total(limite)
    valor = 0
    regulador(limite).each do |r|
      valor = valor + r.price * r.quantity
    end
    valor
  end
  def ivaf(limite)
    return (regulador_total(limite) * 0.16).round(2)
  end
  def conIvaf(limite)
    return (regulador_total(limite) * 1.16).round(2)
  end
end
