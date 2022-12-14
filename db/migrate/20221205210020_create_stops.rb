




class CreateStops < ActiveRecord::Migration[7.0]
  def change
    create_table :stops do |t|
      t.references :itinerary, null: false, foreign_key: true
      t.string :name
      t.string :address

      t.timestamps
    end
  end
end
