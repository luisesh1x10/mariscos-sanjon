class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy,:pay,:paynow]
  before_action :set_table, only: [:create]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @saucer_order = SaucerOrder.new
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end
  
  def pay
    
  end
  
  def paynow
    @order.update(status:2)
    redirect_to tables_path
  end

  # POST /orders
  # POST /orders.json
  def create
    @order =Order.new()
    @order.table = @table
    respond_to do |format|
      if @order.save
        format.html { redirect_to @table, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update()
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end
    
    def set_table
      @table = Table.find(params[:table_id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
end
