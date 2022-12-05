class AddDescriptionToBusiness < ActiveRecord::Migration[7.0]
  def change
    add_column :businesses, :description, :text
  end
end
