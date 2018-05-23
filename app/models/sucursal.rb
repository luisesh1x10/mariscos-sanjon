class Sucursal < ActiveRecord::Base
    has_many :users
    has_many :expenses
    has_many :bags
    has_many :orders
    has_many :tables
    has_many :saucer_orders

    def self.init_sucursal(id)
        puts "inicio"
        User.update_all(sucursal_id:id)
        Expense.update_all(sucursal_id:id)
        Bag.update_all(sucursal_id:id)
        Order.update_all(sucursal_id:id)
        Table.update_all(sucursal_id:id)
        SaucerOrder.update_all(sucursal_id:id)
    end
    
    
    def ingresosBrutos(f1,f2)
        self.saucer_orders.where(:created_at => f1.beginning_of_day+6.hours..f2.end_of_day+6.hours).sum('price*quantity')  
    end
    def descuentoTotal(f1,f2)
        self.saucer_orders.where(:created_at => f1.beginning_of_day+6.hours..f2.end_of_day+6.hours).sum('(price*quantity)*(discount/100)')  
    end
    def ivaTotal(f1,f2)
        tuplas = self.saucer_orders.where(:created_at => f1.beginning_of_day+6.hours..f2.end_of_day+6.hours)
        if (tuplas.count > 0 )
          tuplas = self.saucer_orders.where(:created_at => f1.beginning_of_day+6.hours..f2.end_of_day+6.hours)
          tuplas.sum('((price*quantity) - (price*quantity)*(discount/100)) * (iva/100.0)') #* (tuplas.first.iva.to_f / 100.to_f)
        else
          0
        end 
    end
    def ingresosDescuento(f1,f2)
        ingresosBrutos(f1,f2) - descuentoTotal(f1,f2)
    end
    def ingresosTotal(f1,f2)
        ingresosBrutos(f1,f2) - descuentoTotal(f1,f2) + ivaTotal(f1,f2)
    end

end
