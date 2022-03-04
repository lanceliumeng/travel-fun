class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # index action, products_path will show all products to browser.
  def index
    # for search function, eg: users typed tas for searching,
    # in my server, GET "/products?search_title=tas" for 127.0.0.1,  Parameters: {"title"=>"tas"}, back end will check the DB:
    # SELECT "products".* FROM "products" WHERE (lower(title) LIKE '%tas%'), if it can find sth match, then display match things to front end views
    # else, display all products at views
    if params[:title]
      # The lower() method converts the field on the database side to lowercase.
      # Calling params[:title].downcase converts the provided search term to lowercase also.
      # Array conditions prevent SQL injection in Active Record.
      @products = Product.where("lower(title) LIKE ?", "%#{params[:title].downcase}%")
    else
      @products = Product.all
    end
  end

  # GET /products/1 or /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products or /products.json
  def create
    @product = Product.new(product_params)

    #=> start: we have created a relationship between the user model and product model
    @product.user = current_user   
    #=> end: when we create new product, it will automatically belongs to the current user account
    respond_to do |format|
      if @product.save
        format.html { redirect_to product_url(@product), notice: "Product was successfully created." }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1 or /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to product_url(@product), notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1 or /products/1.json
  def destroy
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:title, :description)
    end
end
