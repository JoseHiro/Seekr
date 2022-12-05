class ProductController < ApplicationController
  def list_all
    @products = Product.all
  end

  def show_selected
    @product = Product.find(params[:id])
  end

  def index
    @products = Product.where(current_user == product.owner)
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end


end
