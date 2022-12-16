class ProductsController < ApplicationController
  def list_all
    seek = params[:filters].nil? ? "" : params[:filters][:seek]
    address = params[:filters].nil? ? "" : params[:filters][:address]
    query = search_engine(seek, address)
    @products = query[0]
    @counter = query[1]
    @display_adding_products_logic = ((controller_name == "itineraries" && action_name == "add_products") || controller_name == "products" && action_name=="list_all" )
    @display_navbar_logic = ((user_signed_in? && (controller_name == "pages" || (controller_name == "itineraries" && (action_name == "new" || action_name == "add_products") ))) || controller_name == "products")
  end

  def show_selected
    @product = Product.find(params[:id])
    @photos = @product.photos
    @markers = [{
      lat: @product.latitude,
      lng: @product.longitude
    }]
  end

  def index
    @business = params[:business_id]
    @products = Business.find(params[:business_id]).products
  end

  def show
    @product = Product.find(params[:id])
    @business = Business.find(params[:business_id])
    @photos = @product.photos

    @markers = [{
        lat: @product.latitude,
        lng: @product.longitude
    }]
  end

  def new
    @product = Product.new
    @business = Business.find(params[:business_id])
  end

  def create
    @product = Product.new(product_params)
    @business = Business.find(params[:business_id])
    @product.latitude = @business.latitude
    @product.longitude = @business.longitude
    @product.business = @business
    if @product.save
      redirect_to business_product_path(@business, @product)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @product = Product.find(params[:id])
    @business = @product.business
  end

  def get_distance
    params[:geo]
  end

  def update
    @business = Business.find(params[:business_id])
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to business_product_path(@business, @product)
    else
      render :edit, :unprocessable_entity
    end
  end

  def destroy
    @business = Business.find(params[:business_id])
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to business_products_path(@business), status: :see_other
  end

  private

  def product_params
    params.require(:product).permit(:category, :brand, :price, :name, :description, :availability, photos: [])
  end

  def search_engine(seek, address)
    products = []
    if seek != "" && address != ""
      Product.search_by_product(seek).each do |product|
        Business.near(address, 20).each do |business|
          products << product if product.business == business
        end
      end
    elsif address != ""
      Business.near(address, 20).each do |business|
        business.products.each do |product|
          products << product unless product.nil?
        end
      end
    elsif seek != ""
      products = Product.search_by_product(seek)
    end
    return [products, products.count || 0] # Polimorfism!!!
  end
end
