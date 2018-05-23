class CorteController < ApplicationController
  before_action :set_sucursal, only: [:index]
  def set_sucursal
      @sucursal = User.find(current_user.id).sucursal
  end
  def index
    @fecha = params[:fecha]
    @fecha  =  Time.now if @fecha.nil? or @fecha == "" 
    @fecha = @fecha.to_date
    f1 = @fecha.beginning_of_day
    f2 = @fecha.end_of_day
    @ingresos =  @sucursal.saucer_orders.where(:created_at => @fecha.beginning_of_day+6.hours..@fecha.end_of_day+6.hours) #.sum('price*quantity')
    @egresos = @sucursal.expenses.where(:created_at => @fecha.beginning_of_day+6.hours..@fecha.end_of_day+6.hours) #.sum('amount')
    
    @sumIngresos =  @sucursal.ingresosBrutos(f1,f2)
    @sumDescuento =  @sucursal.descuentoTotal(f1,f2)
    @sumIva =  @sucursal.ivaTotal(f1,f2)
    @ingresoTotal =  @sucursal.ingresosTotal(f1,f2)
    @sumEgresos = @egresos.sum('amount')
    respond_to do |format|
      format.html  
      format.pdf do
           pdf = CortePdf.new(@ingresos,@egresos,@sumIngresos,@sumEgresos,@sumDescuento,@sumIva,@ingresoTotal)
          send_data pdf.render, filename: 'corte.pdf', type: 'application/pdf', disposition: "inline"
      end
    end
  end
end
