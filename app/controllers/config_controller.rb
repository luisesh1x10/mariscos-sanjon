class ConfigController < ApplicationController
    skip_before_filter :authenticate_user!
    
    def update
        @config = Config.last
        respond_to do |format|
            format.json { render :json =>"Error" }     if params[:iva].nil?
            if @config.update(iva:params[:iva]) 
                format.json { render :json => @config}
            else
                format.json { render :json => "hoa"}
            end
        end
    end
end
