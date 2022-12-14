class PagesController < ApplicationController
  def home
    if user_signed_in?
        @shops = Business.near(current_user.location.address, 20) if current_user.location.present?
        !current_user.location.presence == nil ? @current_location = current_location.location.address : @current_location = ""
    end
    @products = Product.all.last(4)
  end
end
