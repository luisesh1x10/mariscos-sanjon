class CocinaController < ApplicationController
  
  def show
  end
  def terminados
    @direccion = terminados_path
     @pedidos = SaucerOrder.all.where('status = ?',3)
     respond_to do |format|
          format.html {}
          format.json { render :json=> @pedidos  }
          format.js {render :show}
    end
  end
end
