class Itinerary < ApplicationRecord
  belongs_to :saved_itinerary
  has_many :products, through: :product_itineraries
end
