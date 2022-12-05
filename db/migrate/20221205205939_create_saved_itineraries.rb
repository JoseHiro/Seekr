class CreateSavedItineraries < ActiveRecord::Migration[7.0]
  def change
    create_table :saved_itineraries do |t|
      t.date :date
      t.references :user, null: false, foreign_key: true
      t.references :itinerary, null: false, foreign_key: true

      t.timestamps
    end
  end
end
