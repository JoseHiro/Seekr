class AddDefaultValueToItineraries < ActiveRecord::Migration[7.0]
  def change
    change_column_default :itineraries, :current, false
  end
end
