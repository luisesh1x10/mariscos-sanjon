class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy, :historial]
  before_action :set_sucursal, only: [:show, :historial, :index]
  
  # Sucursal.all.each do |sucursal| 
  #   Category.all.each do |category|
  #     CategorySucursal.create(category_id: category.id, sucursal_id: sucursal.id)
  #   end
  # end
  def set_sucursal
      @sucursal = User.find(current_user.id).sucursal
  end
  # GET /categories
  # GET /categories.json
  def index
    @categories = @sucursal.categories
  end

  def historial
    getPedidosHistorial(@category.id)
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    getPedidosActivos(@category.id)
  end
  def getPedidos(id, num, order)
    @id=id
    @bags= @sucursal.bags.joins(:saucer_orders=>[:platillo=>:category]).where("categories.id = ?",id).where.not(:status=>num.to_s).where.not(:status=>4.to_s).uniq.order("created_at #{order}").first(30)
    @pedidos= @sucursal.saucer_orders.joins(:bag, :platillo=>:category).where("categories.id = ?",id).where.not("bags.status = ?",num.to_s).where.not("bags.status = ?",4.to_s).order("created_at #{order}")
     #@pedidos= SaucerOrder.joins(:platillo=>:category).where("categories.id = ? and status is not ? and status is not ?",id,3,4).order(:created_at)
    respond_to do |format|
          format.html {}
          format.json
    end
  end
  def getPedidosActivos(id)
    getPedidos(id, 3, "ASC")
  end

  def getPedidosHistorial(id)
    getPedidos(id, 1, "DESC")
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:name)
    end
end
