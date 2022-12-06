class BusinessesController < ApplicationController
  def new
    @business = Business.new
    @category_list = [
      "Automotive", "Business Support & Supplies", "Computers & Electronics", "Construction & Contractors",
      "Education", "Entertainment", "Food & Dining", "Health & Medicine", "Home & Garden", "Legal & Financial",
      "Manufacturing, Wholesale,Distribution", "Merchants (Retail)", "Miscellaneous", "Personal Care & Services",
      "Real Estate", "Travel & Transportation"
    ]
  end

  def create
    @business = Business.new(business_params)
    @business.owner = current_user

    if @business.save
      redirect_to businesses_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @business = Business.find(params[:id])
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
  end

  def index
    @businesses = Business.all

    # search by shop category
    if params[:query1].present?
      @businesses = Business.where("category ILIKE ?", "%#{params[:query1]}%")
    else
      @businesses = Business.all
    end
  end

  def show
    @business = Business.find(params[:id])
  end

  private

  def business_params
    params.require(:business).permit(:name, :address, :opening_time, :closing_time, :status, :category, :description)
  end
end
