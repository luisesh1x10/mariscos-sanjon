class WelcomeController < ApplicationController
  skip_before_filter :authenticate_user!  
  def index
    @nuevos = Platillo.last(3)
  end
  def menu
  end
end
