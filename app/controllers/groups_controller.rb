class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]
  before_action :set_sucursal, only: [ :show, :edit, :update, :destroy ]

  # GET /groups
  # GET /groups.json
  def index
    @groups = Group.all
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    s = @sucursal.platillos.select("id").where(group_id: @group.id)
    @platillos = Platillo.where(id: s)
    @group
  end
  # Sucursal.all.each do |sucursal| 
  #   Platillo.all.each do |platillo|
  #     PlatillosSucursal.create(platillo_id: platillo.id, sucursal_id: sucursal.id)
  #   end
  # end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.fetch(:group, {})
    end

    def set_sucursal
      @sucursal = User.find(current_user.id).sucursal
    end
end
