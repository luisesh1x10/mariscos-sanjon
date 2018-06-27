class Sucursal < ActiveRecord::Base
    has_many :users
    has_many :expenses
    has_many :bags
    has_many :orders
    has_many :tables
    has_many :saucer_orders
    has_many :invetarios
    after_create :inicializar_inventario
    def self.init_sucursal(id)
        puts "inicio"
        User.update_all(sucursal_id:id)
        Expense.update_all(sucursal_id:id)
        Bag.update_all(sucursal_id:id)
        Order.update_all(sucursal_id:id)
        Table.update_all(sucursal_id:id)
        SaucerOrder.update_all(sucursal_id:id)
    end
    
    
    def ingresosBrutos(f1,f2, user_id = nil)
        if(user_id.nil?)
            self.saucer_orders.where(:created_at => f1.beginning_of_day+6.hours..f2.end_of_day+6.hours).sum('price*quantity')  
        else
            self.saucer_orders.joins(:order).where(:created_at => f1.beginning_of_day+6.hours..f2.end_of_day+6.hours).where("orders.cajero_id = ?",user_id).sum('saucer_orders.price*saucer_orders.quantity')  
        end
       
    end
    def descuentoTotal(f1,f2 , user_id = nil)
        if(user_id.nil?)
            self.saucer_orders.where(:created_at => f1.beginning_of_day+6.hours..f2.end_of_day+6.hours).sum('(price*quantity)*(discount/100)') 
        else
            self.saucer_orders.joins(:order).where(:created_at => f1.beginning_of_day+6.hours..f2.end_of_day+6.hours).where("orders.cajero_id = ?",user_id).sum('(price*quantity)*(discount/100)') 
        end
        
    end
    def ivaTotal(f1,f2, user_id = nil)
         if(user_id.nil?)
            tuplas = self.saucer_orders.where(:created_at => f1.beginning_of_day+6.hours..f2.end_of_day+6.hours)
        else
            tuplas = self.saucer_orders.joins(:order).where(:created_at => f1.beginning_of_day+6.hours..f2.end_of_day+6.hours).where("orders.cajero_id = ?",user_id)
        end
        
        if (tuplas.count > 0 )
          
          tuplas.sum('((price*quantity) - (price*quantity)*(discount/100)) * (iva/100.0)') #* (tuplas.first.iva.to_f / 100.to_f)
        else
          0
        end 
    end
    def ingresosDescuento(f1,f2, user_id = nil)
         if(user_id.nil?)
            ingresosBrutos(f1,f2) - descuentoTotal(f1,f2)
        else
            ingresosBrutos(f1,f2,user_id) - descuentoTotal(f1,f2,user_id)
        end
    end
    def ingresosTotal(f1,f2 , user_id = nil)
        if(user_id.nil?)
            ingresosBrutos(f1,f2) - descuentoTotal(f1,f2) + ivaTotal(f1,f2)
        else
            ingresosBrutos(f1,f2,user_id) - descuentoTotal(f1,f2,user_id) + ivaTotal(f1,f2,user_id)
        end
        
    end
    
    def inicializar_inventario
        Ingrediente.all.each do | ing |
            Inventario.create(sucursal_id:self.id,ingrediente_id:ing.id) unless Inventario.where(sucursal_id:self.id,ingrediente_id:ing.id).count > 0
        end
    end
    def self.inicializar_inventarios_sucursales
        Sucursal.all.each do |suc|    
            Ingrediente.all.each do | ing |
                Inventario.create(sucursal_id:suc.id,ingrediente_id:ing.id) unless Inventario.where(sucursal_id:suc.id,ingrediente_id:ing.id).count > 0
            end
        end
    end

end
