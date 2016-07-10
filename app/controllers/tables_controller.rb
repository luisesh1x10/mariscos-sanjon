class TablesController < ApplicationController
    before_action :set_table, only: [:show]
    def index
        @tables = Table.all
    end
    def show
        @order = Order.new
        @orders = @table.orders.where.not(status:2)
    end
    def set_table
      @table = Table.find(params[:id])
    end
end
