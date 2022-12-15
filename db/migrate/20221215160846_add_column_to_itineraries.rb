class AddColumnToItineraries < ActiveRecord::Migration[7.0]
  def change
    add_column :itineraries, :current, :boolean
  end
end
