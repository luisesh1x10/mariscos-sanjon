class GanaciasController < ApplicationController
  def mes
    @meses = [] 
    page = params[:pagina].to_i
    elementos = 0...19
    elementos.each do |i|
      fecha = Date.today 
      fecha = fecha - ((elementos.size() *page)+i).months
      inicio = fecha.beginning_of_month+6.hours 
      fin = fecha.end_of_month+6.hours
      ingreso = SaucerOrder.where(:created_at => inicio..fin).sum('price*quantity')
      egreso = Expense.where(:created_at => inicio..fin).sum('amount') 
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
      ingreso = SaucerOrder.where(:created_at => inicio..fin).sum('price*quantity')
      egreso = Expense.where(:created_at => inicio..fin).sum('amount') 
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
      ingreso = SaucerOrder.where(:created_at => inicio..fin).sum('price*quantity')
      egreso = Expense.where(:created_at => inicio..fin).sum('amount') 
      @anos << {:inicio => inicio, :fin => fin, :ingreso => ingreso, :egreso =>egreso }
    end
  end
  
end
