class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.all
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
      getPedidos(@category.id)
  end
  def getPedidos(id)
    @id=id
    @bags= Bag.joins(:saucer_orders=>[:platillo=>:category]).where("categories.id = ?",id).where.not(:status=>3.to_s).where.not(:status=>4.to_s).uniq.order(:created_at).first(30)
    @pedidos= SaucerOrder.joins(:bag, :platillo=>:category).where("categories.id = ?",id).where.not("bags.status = ?",3.to_s).where.not("bags.status = ?",4.to_s).order(:created_at)
     #@pedidos= SaucerOrder.joins(:platillo=>:category).where("categories.id = ? and status is not ? and status is not ?",id,3,4).order(:created_at)
    respond_to do |format|
          format.html {}
          format.json
    end
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
