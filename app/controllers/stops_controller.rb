class StopsController < ApplicationController
  def new
    @itinerary = Itinerary.find(params[:id])
    @stop = Stop.new
  end
end
