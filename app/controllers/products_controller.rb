class ProductsController < ApplicationController
  def list_all
    @products = Product.all
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
end
