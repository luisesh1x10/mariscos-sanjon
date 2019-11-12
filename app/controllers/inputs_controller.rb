class InputsController < InheritedResources::Base

  private

    def input_params
      params.require(:input).permit(:resource_id, :cantidad, :precio)
    end
end

