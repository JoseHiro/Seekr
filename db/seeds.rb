# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

categories = ["Automotive", "Computers & Electronics",
"Education", "Food & Dining", "Health & Medicine", "Home & Garden", "Personal Care & Services",
"Travel & Transportation"]


User.destroy_all

addresses = ["mexico city", "Bogota", "Lima","Tokyo"]
10.times do
  user = User.new(first_name:Faker::Name.first_name, last_name:Faker::Name.last_name , password:111111, email:Faker::Internet.email)
  user.save

  business = Business.new(user_id: user.id, name:Faker::Restaurant.name, address:addresses.sample, category:categories.sample)
  business.save
  
  2.times do
    Product.create(business_id:business.id, name:Faker::Book.title, availability:[true,false].sample, price:100, category:categories.sample)
  end

  user.save
  business.save
end
