class Business < ApplicationRecord
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  belongs_to :owner, class_name: :User, foreign_key: :user_id
  has_many :products
end
