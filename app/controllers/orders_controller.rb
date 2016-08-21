class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy,:pay,:paynow]
  before_action :set_table, only: [:create]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end
  def domicilio
    @orders = Order.where("takeaway = ?",true).where.not(:status=>2)
  
  end
  # GET /orders/1
  # GET /orders/1.json
  def show
    @categories=Category.all
    @saucer_order=SaucerOrder.new
     respond_to do |format|
      format.html
      format.pdf do
         pdf = ReportPdf.new(@order)
        send_data pdf.render, filename: 'report.pdf', type: 'application/pdf'
      end
      format.json { render :show}
    end
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
     def customer_params
       params.require(:order).permit(:takeaway,:customer_id)
    end
end
