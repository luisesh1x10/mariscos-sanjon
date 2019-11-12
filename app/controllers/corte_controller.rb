class CorteController < ApplicationController
  before_action :set_sucursal, only: [:index]
  def set_sucursal
      @sucursal = User.find(current_user.id).sucursal
  end
  def index
    if @sucursal.orders.where(status:1).count > 0
      redirect_to "/corte/denegado"
      return
    end
    @fecha = params[:fecha]
    @fecha  =  Time.now if @fecha.nil? or @fecha == "" 
    @fecha = @fecha.to_date
    f1 = @fecha.beginning_of_day
    f2 = @fecha.end_of_day
    @ingresos =  @sucursal.saucer_orders.joins(:order).where(:created_at => @fecha.beginning_of_day+6.hours..@fecha.end_of_day+6.hours).where("orders.cajero_id = ?",current_user.id) #.sum('price*quantity')
    @egresos = @sucursal.expenses.where(:created_at => @fecha.beginning_of_day+6.hours..@fecha.end_of_day+6.hours).where(user_id:current_user.id) #.sum('amount')
    
    ###############
     @ingresosBrutos = @sucursal.ingresosBrutos(f1,f2,current_user.id)
     @descuentoTotal = @sucursal.descuentoTotal(f1,f2,current_user.id)
     @ivaTotal = @sucursal.ivaTotal(f1,f2,current_user.id)
    
    ################
    
    @sumIngresos =  @sucursal.ingresosBrutos(f1,f2,current_user.id)
    @sumDescuento =  @sucursal.descuentoTotal(f1,f2,current_user.id)
    @sumIva =  @sucursal.ivaTotal(f1,f2,current_user.id)
    @ingresoTotal =  @sucursal.ingresosTotal(f1,f2,current_user.id)
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
