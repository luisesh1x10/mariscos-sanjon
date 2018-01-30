class CorteController < ApplicationController
  def index
    @fecha = params[:fecha]
    @fecha  =  Time.now if @fecha.nil? or @fecha == "" 
    @fecha = @fecha.to_date
    @ingresos =  SaucerOrder.where(:created_at => @fecha.beginning_of_day+6.hours..@fecha.end_of_day+6.hours) #.sum('price*quantity')
    @egresos = Expense.where(:created_at => @fecha.beginning_of_day+6.hours..@fecha.end_of_day+6.hours) #.sum('amount')
    
    @sumIngresos =  @ingresos.sum('price*quantity')
    @sumEgresos = @egresos.sum('amount')
    respond_to do |format|
      format.html  
      format.pdf do
           pdf = CortePdf.new(@ingresos,@egresos,@sumIngresos,@sumEgresos)
          send_data pdf.render, filename: 'corte.pdf', type: 'application/pdf', disposition: "inline"
      end
    end
  end
end
