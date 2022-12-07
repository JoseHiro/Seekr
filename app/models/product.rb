class Product < ApplicationRecord
  belongs_to :business
  has_many :product_itineraries

  include PgSearch::Model
  pg_search_scope :search_by_product,
                  against: [:name, :category],
                  using: {
                    tsearch: { prefix: true } # <-- now `superman batm` will return something!
                  }
end
