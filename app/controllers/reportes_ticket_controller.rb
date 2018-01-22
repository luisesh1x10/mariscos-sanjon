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
        elementos.each do |i|
          total = 0
          fecha = Date.today 
          fecha = fecha - (i).months
          inicio = fecha.beginning_of_month+6.hours 
          fin = fecha.end_of_month+6.hours
          cantidad = (inicio.month==12)? 312 :210
          @orders = Order.all.where(status:2).where(:created_at => inicio..fin).order(updated_at: :desc).first(cantidad)
          datos = []
          folio = 4932
          saltos = [5,6,8,12,11,8,4,5,5,10,5,6,8,12,11,8,4,5,5,10,5,6,8,12,11,8,4,5,10,5,10,8,12,11,8,4,5,5,5,10]
          cont = 0 
          index = 0
          fecha = fin
          @orders.each do |order|
            if cont == saltos[index]
              index += 1
              count = 0
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
    def generador_ticket
      
    end
end
