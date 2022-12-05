class CreateBusinesses < ActiveRecord::Migration[7.0]
  def change
    create_table :businesses do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :address
      t.time :opening_time
      t.time :closing_time
      t.string :category
      t.boolean :open

      t.timestamps
    end
  end
end
