class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.references :business, null: false, foreign_key: true
      t.string :name
      t.boolean :availability
      t.float :price
      t.string :brand
      t.string :category

      t.timestamps
    end
  end
end
