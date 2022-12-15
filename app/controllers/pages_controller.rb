class PagesController < ApplicationController
  def home
    if user_signed_in?
        @shops = Business.near(current_user.location.address, 20) if current_user.location.present?
        !current_user.location.presence == nil ? @current_location = current_location.location.address : @current_location = ""
        @itinerary = current_user.current_itinerary
        @stops = @itinerary.nil? ? 0 : trip_stops(@itinerary)
        @date = date_of_itinerary(@itinerary)
    end
    @products = Product.all.last(4)
  end

  private

  def trip_stops(itinerary)
    counter = 1
    actual_business = itinerary.products.first.business
    itinerary.products.each do |product|
      counter += 1 unless product.business == actual_business
      actual_business = product.business
    end
    return counter
  end

  def date_of_itinerary(itinerary)
    current_user.saved_itineraries.each do |saved_itinerary|
      return saved_itinerary.date if saved_itinerary.itinerary == itinerary
    end
    return Date.new
  end
end
