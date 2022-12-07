class ItinerariesController < ApplicationController
  def new
    seek = params[:filters][:seek]
    address = params[:filters][:address]
    @products = search_engine(seek, address)
  end

  private

  # The seach engine method is using pgsearch gem. To edit the query setting go to the Product Model.
  def search_engine(seek, address)
    if seek != "" && address != ""
      products = []
      Product.search_by_product(seek).each { |prod| products << prod if Business.near(product.business.address, 20) }
    elsif address != ""
      Business.near(address, 20).each { |business| business.products.each { |product| products << product } }
    elsif seek != ""
      products = Product.search_by_product(seek)
    else
      products = Products.all
    end
    return products
  end
end
