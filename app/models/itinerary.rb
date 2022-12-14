class Itinerary < ApplicationRecord
  has_many :saved_itineraries
  has_many :product_itineraries
  has_many :products, through: :product_itineraries
  has_many :stops

  def has?(element)
    products = self.products
    result = products.select { |product| product == element }
    return result.length == 1
  end
end
