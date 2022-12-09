class Product < ApplicationRecord
  belongs_to :business
  has_many :product_itineraries
  has_many_attached :photos
end
