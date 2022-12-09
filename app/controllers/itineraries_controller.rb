class ItinerariesController < ApplicationController
  def new
    seek = params[:filters].nil? ? "" : params[:filters][:seek]
    address = params[:filters].nil? ? "" : params[:filters][:address]
    query = search_engine(seek, address)
    @products = query[0]
    @counter = query[1]
  end

  def create
    @product = Product.find(params[:product_id])
    @itinerary = Itinerary.new(new_itinerary_params)
    if @itinerary.save
      saved_itinerary = SavedItinerary.new(itinerary: @itinerary, user: current_user, date: Date.today)
      if saved_itinerary.save
        product_itinerary = ProductItinerary.new(itinerary: @itinerary, product: @product)
        redirect_to my_itineraries_path(@itinerary) if product_itinerary.save
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

  def update
    @itinerary = Itinerary.find(params[:id])
    @saved_itinerary = SavedItinerary.find(params[:itinerary][:saved_itinerary][:saved_itinerary_id])
    @itinerary.update(new_itinerary_params)
    respond_to do |format|
      format.html { redirect_to my_itineraries_path }
      format.text { render partial: "itineraries/itinerary_info", locals: {saved_itinerary: @saved_itinerary}, formats: [:html] }
    end
  end

  def update_element
    element = params[:element]
    if element == "name"
      @itinerary = Itinerary.find(params[:id])
      @itinerary.update(new_itinerary_params)
      respond_to do |format|
        format.html { redirect_to my_itineraries_path(@itinerary) }
        format.text { render partial: "itineraries/itinerary_show_name", locals: {itinerary: @itinerary}, formats: [:html] }
      end
    elsif element == "date"
      @saved_itinerary = SavedItinerary.find(params[:id])
      @saved_itinerary.update(saved_itinerary_params)
      respond_to do |format|
        format.html { redirect_to my_itineraries_path(@itinerary) }
        format.text { render partial: "itineraries/itinerary_show_date", locals: {saved_itinerary: @saved_itinerary}, formats: [:html] }
      end
    end
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

  def saved_itinerary_params
    params.require(:saved_itinerary).permit(:date)
  end
end
