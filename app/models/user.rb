class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :avatar
  has_many :businesses
  has_many :saved_itineraries
  
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

end
