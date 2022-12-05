class Product < ApplicationRecord
  belongs_to :business
  has_many :product_itinerary
end
