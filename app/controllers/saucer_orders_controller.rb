class SaucerOrdersController < ApplicationController
  before_action :set_saucer_order, only: [:show, :edit, :update,:update_clave, :destroy]
  before_action :set_order, only: [:create,:new]
  before_action :set_sucursal, only: [:index, :create_bag, :create]
  def set_sucursal
      @sucursal = User.find(current_user.id).sucursal
  end

  # GET /saucer_orders
  # GET /saucer_orders.json
  def index
    @saucer_orders = @sucursal.saucer_orders
  end

  # GET /saucer_orders/1
  # GET /saucer_orders/1.json
  def show
  end

  # GET /saucer_orders/new
  def new
    @saucer_order = SaucerOrder.new
  end

  # GET /saucer_orders/1/edit
  def edit
  end

  # POST /saucer_orders
  # POST /saucer_orders.json
  def create_bag
    exito=true
    parametros = JSON.parse(params[:datos])
    parametros.each do |aux|
      bag= Bag.new
      bag.sucursal_id = @sucursal.id
      bag.save
      aux.each do |record|
        row = SaucerOrder.new(order_id:record["order_id"],platillo_id:record["platillo_id"],quantity:record["quantity"],notes:record["notes"])
        row.price = row.platillo.price.to_f
        row.user=current_user
        row.bag=bag
        row.sucursal_id = @sucursal.id
        exito =false unless  row.save
      end
    end
    respond_to do |format|
      if exito
        format.json { render json:parametros, status: :created }
      else
        format.json { render json: {error:"fallo"}, status: :unprocessable_entity }
      end
    end
  end
  
  def create
    bag=Bag.new
    bag.sucursal_id = @sucursal.id
    bag.save
    @saucer_order = SaucerOrder.new(saucer_order_params)
    @saucer_order.price = @saucer_order.platillo.price.to_f
    @saucer_order.user=current_user
    @saucer_order.bag=bag
    @saucer_order.sucursal_id = @sucursal.id
    unless  @order.nil?
      @saucer_order.order_id = @order.id
    end
      respond_to do |format|
      if @saucer_order.save
        format.html { redirect_to @saucer_order, notice: 'Saucer order was successfully created.' }
        format.json { render :show, status: :created, location: @saucer_order }
      else
        format.html { render :new }
        format.json { render json: @saucer_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /saucer_orders/1
  # PATCH/PUT /saucer_orders/1.json
  def update
    respond_to do |format|
      if @saucer_order.update(saucer_order_params)
        format.html { redirect_to @saucer_order, notice: 'Saucer order was successfully updated.' }
        format.json { render :show, status: :ok, location: @saucer_order }
      else
        format.html { render :edit }
        format.json { render json: @saucer_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /saucer_orders/1
  # DELETE /saucer_orders/1.json
  def destroy
    justi = (params[:justificacion].nil?)? "" :  params[:justificacion]
    
    order=@saucer_order.order
    if order.status==2
      redirect_to pay_path(order)
    else  
      Cancellation.create(user_id:current_user.id,justificacion:justi,platillo:@saucer_order.platillo.name,quantity:@saucer_order.quantity,sucursal_id:current_user.sucursal_id)
      @saucer_order.destroy
      respond_to do |format|
        format.html { redirect_to pay_path(order), notice: 'Saucer order was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_saucer_order
      @saucer_order = SaucerOrder.find(params[:id])
    end
    def set_order
      @order = Order.find(params[:order_id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def saucer_order_params
      params.require(:saucer_order).permit(:bag_id,:order_id,:platillo_id,:notes,:quantity,:discount,:iva)
    end
    def datos_bag(record)
        record.require(:datos).permit(:bag_id,:order_id,:platillo_id,:notes,:status,:quantity,:discount,:iva )
    end
end
