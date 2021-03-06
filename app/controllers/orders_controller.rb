class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :set_trip, only: [:new, :create]
  # GET /orders
  # GET all orders view page
  # Renders orders list view page. 
  def index
    # @orders = Order.all
    # Ransack gem for for searching/filtering orders
    @ransack_path = orders_path
    @q = Order.ransack(params[:q])
    @pagy, @orders = pagy(@q.result.includes(:user))  # gem pagy set up, then I can sort users at orders index view
    authorize @orders #for only specific role(order_policy.rb) can do this action
  end
  
  # def my clients method which let operator find the trips belong to current operator user and they are going to find the orders in these trips 
  def my_clients
    @ransack_path = my_clients_orders_path  #=> search field only show the operator's clients not all clients
    @q = Order.joins(:trip).where(trips: {user: current_user} ).ransack(params[:q])
    @pagy, @orders = pagy(@q.result.includes(:user))
    render 'index'
  end


  # GET /orders/1 or /orders/1.json
  #When the user selects this action, the controller will execute any code in the appropriate section - "def show" - and then by default will render a template of the same name - "show.html.erb".
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
