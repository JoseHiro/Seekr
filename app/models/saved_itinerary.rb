class SavedItinerary < ApplicationRecord
  belongs_to :user
  belongs_to :itinerary

  def self.has_current?(itineraries)
    itineraries.each do |itinerary|
      if itinerary.current
        return true
      end
    end
  end
end
