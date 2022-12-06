class ItinerariesController < ApplicationController
  def new
    if params[:query].present?
    else
    end
    @products = Product.all
  end
end
