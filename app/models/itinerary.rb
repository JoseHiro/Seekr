class Itinerary < ApplicationRecord
  has_many :saved_itineraries
  has_many :product_itineraries
  has_many :products, through: :product_itineraries
end
