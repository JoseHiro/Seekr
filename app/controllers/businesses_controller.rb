class BusinessesController < ApplicationController
  CATEGORY_LIST = [
    "Automotive", "Business Support & Supplies", "Computers & Electronics", "Construction & Contractors",
    "Education", "Entertainment", "Food & Dining", "Health & Medicine", "Home & Garden", "Legal & Financial",
    "Manufacturing, Wholesale,Distribution", "Merchants (Retail)", "Miscellaneous", "Personal Care & Services",
    "Real Estate", "Travel & Transportation"
  ]
  def new
    @business = Business.new
    @category_list = CATEGORY_LIST
  end

  def create
    @business = Business.new(business_params)
    @owner = current_user
    @business.owner = @owner

    if @business.save
      redirect_to businesses_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @business = Business.find(params[:id])
    @category_list = CATEGORY_LIST
  end

  def update
    @business = Business.find(params[:id])
    if @business.update(business_params)
      redirect_to business_path(@business)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def delete
    @business = Business.find(params[:id])
    @business.delete
    redirect_to businesses_path
  end

  def index
    @businesses = current_user.businesses
  end

  def show
    @business = Business.find(params[:id])
    @photos = @business.photos
    @markers = [{
      lat: @business.latitude,
      lng: @business.longitude
  }]
  end

  private

  def business_params
    params.require(:business).permit(:name, :address, :opening_time, :closing_time, :status, :category, :description, photos: [])
  end
end
