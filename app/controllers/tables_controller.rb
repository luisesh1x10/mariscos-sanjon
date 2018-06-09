class TablesController < ApplicationController
    before_action :set_table, only: [:show]
    before_action :set_sucursal, only: [:index]
    def set_sucursal
        @sucursal = User.find(current_user.id).sucursal
    end
    def index
        @tables = @sucursal.tables.all.order(:name)
    end
    def show
        @order = Order.new
        @orders = @table.orders.where.not(status:2)
    end
    def set_table
      @table = Table.find(params[:id])
    end
    
end
