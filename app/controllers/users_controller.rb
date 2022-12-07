class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def update_address
    raise
  end
end
