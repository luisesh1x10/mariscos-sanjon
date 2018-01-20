class ReportesTicketController < ApplicationController
    before_action :set_order, only: [:show]
    def index 
        
    end
  #  def historial
  #    @orders = Order.all.where(status:2).order(updated_at: :desc).first(30)
  #  end
    def show
        @folio = params[:folio]
        @categories=Category.all
        @saucer_order=SaucerOrder.new
         respond_to do |format|
          format.html
          format.pdf do
             pdf = Report2Pdf.new(@order,@folio)
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
        elementos = 0...25
        elementos.each do |i|
          total = 0
          fecha = Date.today 
          fecha = fecha - (i).months
          inicio = fecha.beginning_of_month+6.hours 
          fin = fecha.end_of_month+6.hours
          @orders = Order.all.where(status:2).where(:created_at => inicio..fin).order(updated_at: :desc).first(10)
          datos = []
          folio = 4932
          @orders.each do |order|
            folio = folio - 1
            t = order.regulador_total(200)
            total = total + t
            datos << { :order  => order , :valor=> t, :folio => folio}
          end
          @tickets << {:periodo => "#{inicio.strftime("%d/%m/%Y")} ... #{fin.strftime("%d/%m/%Y")}", :datos=> datos , :total => total
          }
        end
        render :json => @tickets.to_json
    end
end
