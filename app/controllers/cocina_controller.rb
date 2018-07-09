class CocinaController < ApplicationController
  before_action :set_sucursal, only: [:terminados]
  def set_sucursal
      @sucursal = User.find(current_user.id).sucursal
  end
  def show
  end
  def terminados
    @direccion = terminados_path
     @pedidos = @sucursal.bags
     respond_to do |format|
          format.html {}
          format.json { render :json=> @pedidos  }
          format.js {render :show}
    end
  end
end
