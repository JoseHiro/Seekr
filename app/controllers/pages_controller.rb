class PagesController < ApplicationController
  def home
    if user_signed_in?
        @shops = Business.near(current_user.location.address, 20) if current_user.location.present?
    end
  end
end
