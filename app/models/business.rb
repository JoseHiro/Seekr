class Business < ApplicationRecord
  belongs_to :owner, class_name: :User, foreign_key: :user_id
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  after_validation :geocode_products, if: :will_save_change_to_address?
  has_many :products
  has_many_attached :photos

  def geocode_products
    products.each do |p|
      p.latitude = latitude if latitude
      p.longitude = longitude if longitude
      p.save
    end
  end
end
