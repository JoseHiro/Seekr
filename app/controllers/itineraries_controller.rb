class ItinerariesController < ApplicationController
  def new
    seek = params[:filters].nil? ? "" : params[:filters][:seek]
    address = params[:filters].nil? ? "" : params[:filters][:address]
    query = search_engine(seek, address)
    @products = query[0]
    @counter = query[1]
  end

  def create
    product = Product.find(params[:product_id])
    @itinerary = Itinerary.new(new_itinerary_params)
    if @itinerary.save
      saved_itinerary = SavedItinerary.new(itinerary: @itinerary, user: current_user)
      if saved_itinerary.save
        redirect_to my_itineraries_path(@itinerary)
      else
        redirect_to root_path
      end
    end
  end

  def show
    @itinerary = Itinerary.find(params[:id])
  end

  def index
    @saved_itineraries = current_user.saved_itineraries
  end

  def add_more_products
    @itinerary = Itinerary.find(params[:id])
  end

  private

  # The seach engine method is using pgsearch gem. To edit the query setting go to the Product Model.
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
    return [products, products.count || 0]
  end

  def new_itinerary_params
    params.require(:itinerary).permit(:name, :status)
  end
end
