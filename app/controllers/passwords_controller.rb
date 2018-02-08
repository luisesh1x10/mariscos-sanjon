class PasswordsController < ApplicationController
  def verificar
    if params[:pass].nil? or params[:pass] == ""
      render :json => false 
      return;
    end
    pass = params[:pass] 
    if Password.where(pass:pass).count > 0
      render :json => true
    else
      render :json => false
    end
  end
end
