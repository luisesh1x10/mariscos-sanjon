class CocinaController < ApplicationController
  
  def show
  end
  def terminados
    @direccion = terminados_path
     @pedidos = SaucerOrder.all
     respond_to do |format|
          format.html {}
          format.json { render :json=> @pedidos  }
          format.js {render :show}
    end
  end
end
