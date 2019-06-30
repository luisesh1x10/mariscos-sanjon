class RequetsController < InheritedResources::Base
  def avanzar()
    Requet.find(params[:id]).avanzar
    redirect_to requets_path
  end
  def terminadas()
    @requets = Requet.where(status: 2)
    render :index
  end
  def index()
    @requets = Requet.where.not(status: 2)
  end
  private

    def requet_params
      params.require(:requet).permit(:sucursal_id, :status , :anotaciones)
    end
end

