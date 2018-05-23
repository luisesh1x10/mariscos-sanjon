class GanaciasController < ApplicationController
   before_action :setSucursal, only: [:mes, :semana, :ano]
  def sucursales
    render :json => Sucursal.all.to_json
  end
  def mes
    @meses = [] 
    page = params[:pagina].to_i
    elementos = 0...19
    elementos.each do |i|
      fecha = Date.today 
      fecha = fecha - ((elementos.size() *page)+i).months
      inicio = fecha.beginning_of_month+6.hours 
      fin = fecha.end_of_month+6.hours
      ingreso = @sauceOrders.where(:created_at => inicio..fin).sum('(price*quantity) - (price*quantity)*(discount/100)')
      egreso = @expenses.where(:created_at => inicio..fin).sum('amount') 
      @meses << {:inicio => inicio, :fin => fin, :ingreso => ingreso, :egreso =>egreso }
      
    end
  end

  def semana
    @semanas = [] 
    page = params[:pagina].to_i
    elementos = 0...19
    elementos.each do |i|
      fecha = Date.today 
      fecha = fecha - ((elementos.size() *page)+i).weeks
      inicio = fecha.beginning_of_week+6.hours 
      fin = fecha.end_of_week+6.hours
      ingreso = @sauceOrders.where(:created_at => inicio..fin).sum('(price*quantity) - (price*quantity)*(discount/100)')
      egreso = @expenses.where(:created_at => inicio..fin).sum('amount') 
      @semanas << {:inicio => inicio, :fin => fin, :ingreso => ingreso, :egreso =>egreso }
    end
  end

  def ano
    @anos = [] 
    page = params[:pagina].to_i
    elementos = 0...19
    elementos.each do |i|
      fecha = Date.today 
      fecha = fecha - ((elementos.size() *page)+i).years
      inicio = fecha.beginning_of_year+6.hours 
      fin = fecha.end_of_year+6.hours
      ingreso = @sauceOrders.where(:created_at => inicio..fin).sum('(price*quantity) - (price*quantity)*(discount/100)')
      egreso = @expenses.where(:created_at => inicio..fin).sum('amount') 
      @anos << {:inicio => inicio, :fin => fin, :ingreso => ingreso, :egreso =>egreso }
    end
  end
  def setSucursal
    unless params[:sucursal].nil? or params[:sucursal]==""
      sucursal = Sucursal.find(params[:sucursal].to_i) 
      @sauceOrders = sucursal.saucer_orders
      @expenses = sucursal.expenses
    else
      @sauceOrders = SaucerOrder.all
      @expenses = Expense.all
    end
  end
end
