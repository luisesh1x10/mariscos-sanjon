class ReportesTicketController < ApplicationController
    before_action :set_order, only: [:show]
    def index 
        
    end
  #  def historial
  #    @orders = Order.all.where(status:2).order(updated_at: :desc).first(30)
  #  end
  def reporte3
    require 'json'
    json_string = params[:datos]
    hash = JSON.parse(json_string)
    lista = hash["lista"]
    folio = hash["folio"]
    fecha = hash["fecha"]
    hora = hash["hora"]
    mesero = hash["mesero"]
    total = hash["total"]
     respond_to do |format|
      format.pdf do
         pdf = Report3Pdf.new(lista,folio,fecha,hora,mesero,total)
        send_data pdf.render, filename: 'report3.pdf', type: 'application/pdf', disposition: "inline"
      end
      format.json { render :show}
    end
  end
    def show
        @folio = params[:folio]
        fecha = params[:fecha]
        @categories=Category.all
        @saucer_order=SaucerOrder.new
         respond_to do |format|
          format.html
          format.pdf do
             pdf = Report2Pdf.new(@order,@folio,fecha)
            send_data pdf.render, filename: 'report.pdf', type: 'application/pdf', disposition: "inline"
          end
          format.json { render :show}
        end
      end
    def set_order
      @order = Order.find(params[:id])
    end
    def historial
        @tickets = [] 
        elementos = 0...4
        folio = 4932 + 522
        elementos.each do |i|
          total = 0
          fecha = Date.today 
          fecha = fecha - (i).months
          inicio = fecha.beginning_of_month+6.hours 
          fin = fecha.end_of_month+6.hours
          cantidad = (inicio.month==12)? 312 :210
          @orders = Order.all.where(status:2).where(:created_at => inicio..fin).order(updated_at: :desc).first(cantidad)
          datos = []
          
          saltos = [5,6,8,11,10,7,6,8,7,5,5,6,7,5,9,10,7,5,7,6,10,6,8,10,10,8,5,5,8] if fin.day == 28
          saltos = [5,6,8,11,10,7,6,5,7,5,5,6,7,5,9,10,7,5,7,5,5,6,8,10,10,8,4,5,5,3,10] if fin.day == 31
          saltos = [5,6,8,12,11,8,4,5,8,5,5,6,8,5,11,12,7,5,7,5,5,6,8,12,11,8,4,5,5,3] if fin.day == 30
          saltos = [10,17,13,11,10,7,2,13,7,10,12,10,7,5,9,25,7,10,7,14,16,14,8,10,0,8,8,14,15,3,10] if fin.month == 12
          cont = 0 
          index = 0
          fecha = fin
          @orders.each do |order|
            if cont == saltos[index]
              index += 1
              cont = 0
              fecha = fecha - 1.day
            end
            cont += 1
            folio = folio - 1
            t = order.regulador_total(200)
            total = total + t
            datos << { :order  => order , :valor=> t, :folio => folio,:fecha => fecha.strftime("%d/%m/%Y")}
          end
          @tickets << {:periodo => "#{inicio.strftime("%d/%m/%Y")} ... #{fin.strftime("%d/%m/%Y")}", :datos=> datos , :total => total,:iva => total*0.16 
          }
        end
        render :json => @tickets.to_json
    end
    def tickets_linea 
       @tickets = [] 
       datos = []
        elementos = 0...4
        folio = 4932 + 522
        elementos.each do |i|
          total = 0
          fecha = Date.today 
          fecha = fecha - (i).months
          inicio = fecha.beginning_of_month+6.hours 
          fin = fecha.end_of_month+6.hours
          cantidad = (inicio.month==12)? 312 :210
          @orders = Order.all.where(status:2).where(:created_at => inicio..fin).order(updated_at: :desc).first(cantidad)
          saltos = [5,6,8,11,10,7,6,8,7,5,5,6,7,5,9,10,7,5,7,6,10,6,8,10,10,8,5,5,8] if fin.day == 29
          saltos = [5,6,8,11,10,7,6,5,7,5,5,6,7,5,9,10,7,5,7,5,5,6,8,10,10,8,4,5,5,3,10] if fin.day == 31
          saltos = [5,6,8,12,11,8,4,5,8,5,5,6,8,5,11,12,7,5,7,5,5,6,8,12,11,8,4,5,5,3] if fin.day == 30
          saltos = [10,17,13,11,10,7,2,13,7,10,12,10,7,5,9,25,7,10,7,14,16,14,8,10,0,8,8,14,15,3,10] if fin.month == 12
          cont = 0 
          index = 0
          fecha = fin
          @orders.each do |order|
            if cont == saltos[index]
              index += 1
              cont = 0
              fecha = fecha - 1.day
            end
            cont += 1
            folio = folio - 1
            t = order.regulador_total(200)
            total = total + t
            datos << { :order  => order , :valor=> t, :folio => folio,:fecha => fecha.strftime("%d/%m/%Y")}
          end
          #@tickets << {:periodo => "#{inicio.strftime("%d/%m/%Y")} ... #{fin.strftime("%d/%m/%Y")}", :datos=> datos , :total => total,:iva => total*0.16 }
        end
        
         respond_to do |format|
          format.pdf do
             pdf = Report4Pdf.new(datos)
            send_data pdf.render, filename: 'report.pdf', type: 'application/pdf', disposition: "inline"
          end
          format.json { render :show}
        end 
    end
    def generador_ticket
      
    end
end
