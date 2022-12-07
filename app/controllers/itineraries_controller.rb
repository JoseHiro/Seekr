class ItinerariesController < ApplicationController
  def new
    seek = params[:filters].nil? ? "" : params[:filters][:seek]
    address = params[:filters].nil? ? "" : params[:filters][:address]
    @products = search_engine(seek, address)
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
    else
      products = Product.all
    end
    return products
  end
end
