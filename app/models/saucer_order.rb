class SaucerOrder < ActiveRecord::Base
  belongs_to :platillo
  belongs_to :order
  belongs_to :bag
  belongs_to :user
  belongs_to :sucursal
  validates_presence_of :platillo
  validates_presence_of :order
  validates :platillo_id,
  :order_id,
  :bag_id,
  presence:true
  validates :quantity, :inclusion => {:in => [nil,1,2,3,4,5]}
  
  before_save :default_values
  def default_values
    if self.quantity.nil?
      self.quantity||=1
    end
  end
   validates :takeaway,
    :inclusion => { :in => [nil,true, false] }
  validates :takeaway,
    :presence => { :if => 'takeaway.nil?' }

  def self.ingresosBrutos(f1,f2)
    SaucerOrder.where(:created_at => f1.beginning_of_day+6.hours..f2.end_of_day+6.hours).sum('price*quantity')  
  end
  def self.descuentoTotal(f1,f2)
    SaucerOrder.where(:created_at => f1.beginning_of_day+6.hours..f2.end_of_day+6.hours).sum('(price*quantity)*(discount/100)')  
  end
  def self.ivaTotal(f1,f2)
    tuplas = SaucerOrder.where(:created_at => f1.beginning_of_day+6.hours..f2.end_of_day+6.hours)
    if (tuplas.count > 0 )
      tuplas = SaucerOrder.where(:created_at => f1.beginning_of_day+6.hours..f2.end_of_day+6.hours)
      tuplas.sum('((price*quantity) - (price*quantity)*(discount/100)) * (iva/100.0)') #* (tuplas.first.iva.to_f / 100.to_f)
    else
      0
    end 
  end
  def self.ingresosDescuento(f1,f2)
    ingresosBrutos(f1,f2) - descuentoTotal(f1,f2)
  end
  def self.ingresosTotal(f1,f2)
    ingresosBrutos(f1,f2) - descuentoTotal(f1,f2) + ivaTotal(f1,f2)
  end
  def valorTotal
    price * quantity
  end
  def descuentoTotal
    valorTotal * (discount/100)
  end
  def valorMenosDescuento
    valorTotal - descuentoTotal
  end
  def ivaTotal
    valorMenosDescuento * (iva.to_f/100)
  end
  def total
    valorMenosDescuento + ivaTotal
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