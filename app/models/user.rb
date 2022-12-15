class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :avatar
  has_many :businesses
  has_many :saved_itineraries
  has_many :itineraries, through: :saved_itineraries
  has_one :location


  def current_itinerary
    self.itineraries.each do |itinerary|
      return itinerary if itinerary.current
    end
    return nil # if not current find among the user itineraries, return nil.
  end
end
