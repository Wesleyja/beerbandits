# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
require 'faker'
require 'csv'
# Examples:
csv_options = { col_sep: ',', quote_char: '"', headers: :first_row }
brands = ["BWS", "Liqourland", "Dan Murphy's", "First Choice"]
drinks_filepath = 'drinks.csv'

puts "Making Users"
10.times do
  User.create(username: Faker::Internet.username,password: 'password')
  puts "#{User.last.username}"
end
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "Making Brands"
Brand.new(name: "BWS" ,logo: )
Brand.new(name: "Liqourland" ,logo: )
Brand.new(name: "Dan Murphy's" ,logo: )
Brand.new(name: "First Choice" ,logo: )

10.times do
  new_store = Store.new(latitude: rand(-37.84578..-37.77509) ,longitude: rand(144.97737..145.03860))
  new_store.brand_id = Brand.find(name: brands.sample)
  new_store.name = "#{Faker::Company.name}'s #{new_store.brand_id}"
end



# 24 pack beers
CSV.foreach(drinks_filepath, csv_options) do |row|
  Drink.create(name: row['Name'], category: row['Category'],volume: row['Volume'],abv: row['ABV'],strength: row['Strength'])
  Product.create(beer_id: Drink.last.id ,size: 24)
  recent_shops = []
  10.times do
    Inventory.create(price_cents: rand(4000-6500) ,store_id: (Store.first.id..Store.last.id).grep_v(recent_shops).sample
    Inventory_product.new(inventory_id: Inventory.last.id ,product_id: Product.last.id)
    puts "#{Product.last.size} pack of #{Drink.last.name} for $#{(Inventory.last.price_cents / 100).round(2)} at #{Store.find(Inventory.store_id).name}"
    recent_shops << Inventory.last.store_id
  end
  Product.create(beer_id: Drink.last.id ,size: 6)
  recent_shops = []
  10.times do
    Inventory.create(price_cents: rand(4000-6500) ,store_id: (Store.first.id..Store.last.id).grep_v(recent_shops).sample
    Inventory_product.new(inventory_id: Inventory.last.id ,product_id: Product.last.id)
    puts "#{Product.last.size} pack of #{Drink.last.name} for $#{(Inventory.last.price_cents / 100).round(2)} at #{Store.find(Inventory.store_id).name}"
    recent_shops << Inventory.last.store_id
  end
end
