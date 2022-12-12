class Api::V1::RoutesController < Api::V1::BaseController
  def show
    @businesses = []
    itinerary = Itinerary.find(params[:id])
    itinerary.products.each do |product|
      @businesses << product.business
    end
  end
end
