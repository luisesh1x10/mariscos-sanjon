class CocinaController < ApplicationController
  def barra_fria
    @direccion = barra_fria_path
    getPedidos("Barra fria")
  end
  def show
  end
  def barra_caliente
    @direccion = barra_caliente_path
    getPedidos("Barra caliente")
  end
  def getPedidos(val)
     aux= Category.where("name = ?",val).first.platillos
     @pedidos=[]
    aux.each do |a|
        a.saucerOrders.each do |x|
        @pedidos.push(x) unless x.status==3
      end
    end
    @pedidos.sort!
    respond_to do |format|
          format.html {}
          format.json { render :json=> @pedidos  }
          format.js {render :show}
    end
  end
end
