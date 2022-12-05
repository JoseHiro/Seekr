class Itinerary < ApplicationRecord
  belongs_to :saved_itineraries
  has_many :products, through: :product_itinerary
end
