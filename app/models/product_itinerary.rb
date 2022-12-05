class ProductItinerary < ApplicationRecord
  belongs_to :product
  belongs_to :itinerary
end
