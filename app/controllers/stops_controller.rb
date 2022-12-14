class StopsController < ApplicationController
  def new
    @itinerary = Itinerary.find(params[:id])
    @stop = Stop.new
  end

  def create
    @itinerary = Itinerary.find(params[:id])
    @stop = Stop.new(stop_params)
    @stop.itinerary = @itinerary
    if @stop.save
      redirect_to my_itineraries_path(@itinerary)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def delete
  end

  private

  def stop_params
    params.require(:stop).permit(:name, :address)
  end
end
