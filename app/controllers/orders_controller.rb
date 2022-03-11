class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :set_trip, only: [:new, :create]
  # GET /orders or /orders.json
  def index
    # @orders = Order.all
    @pagy, @orders = pagy(Order.all)  # gem pagy set up
    authorize @orders #for only specific role(order_policy.rb) can do this action
  end

  # GET /orders/1 or /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
    authorize @order #for only specific role(order_policy.rb) can do this action
  end

  #create action for place new order 
  def create
    # @order = Order.new(order_params)
    # @order.price = @order.trip.price  #when place order, order doesn't need to create its own price, it price needs to equal the trip's price
    # respond_to do |format|
    #   if @order.save
    #     format.html { redirect_to order_url(@order), notice: "Order was successfully created." }
    #     format.json { render :show, status: :created, location: @order }
    #   else
    #     format.html { render :new, status: :unprocessable_entity }
    #     format.json { render json: @order.errors, status: :unprocessable_entity }
    #   end
    # end

    #before I don't set any payment function, I create the method below:
    # if trip price != 0, then cannot make payment,get alert msg and redirect to new order path.
    # else, if price is free, then can place the order
    # @trip in private method set_trip
    if @trip.price > 0
      flash[:alert] = "You can not access paid trip yet."
      redirect_to new_trip_order_path(@trip)
    else
      @order = current_user.purchase_trip(@trip)
      redirect_to trip_path(@trip), notice: "Yeah! You made an order!"
    end
  end

  # PATCH/PUT /orders/1 or /orders/1.json
  def update
    authorize @order #for only specific role(order_policy.rb) can do this action
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to order_url(@order), notice: "Order was successfully updated." }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1 or /orders/1.json
  def destroy
    authorize @order #for only specific role(order_policy.rb) can do this action
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: "Order was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.friendly.find(params[:id])  #=> friendly id gem
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:rating, :review)
    end

    def set_trip
      @trip = Trip.friendly.find(params[:trip_id])
    end
end
