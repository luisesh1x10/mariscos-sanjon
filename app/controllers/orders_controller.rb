class OrdersController < InheritedResources::Base

  private

    def order_params
      params.require(:order).permit(:tables_id)
    end
end

