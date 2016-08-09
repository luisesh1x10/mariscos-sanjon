class CustomersController < InheritedResources::Base

  private

    def customer_params
      params.require(:customer).permit(:nombre, :telefono, :calle, :colonia, :numero_interior, :numero_exterior)
    end
end

