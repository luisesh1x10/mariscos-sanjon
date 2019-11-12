class MeseroController < ApplicationController
  before_action :redirect, only: [:pedido]
  def redirect
    redirect_to '/requets' if current_user.tipo == 4
  end
  
  def pedido
  end
end
