# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
require 'faker'
require 'csv'
# require 'byebug'
puts "Destorying Users"
User.destroy_all
puts "Destorying Inventory Product"
InventoryProduct.destroy_all
puts "Destorying Product"
Product.destroy_all
puts "Destorying Inventory"
Inventory.destroy_all
puts "Destorying Drinks"
Drink.destroy_all
puts "Destorying Stores"
Store.destroy_all
puts "Destorying Brans"
Brand.destroy_all

# Examples:
csv_options = { col_sep: ',', quote_char: '"', headers: :first_row }
brands = ["BWS", "Liqourland", "Dan Murphy's", "First Choice"]
csv_text = File.read(Rails.root.join('lib', 'seeds', 'drinks.csv'))
csv = CSV.parse(csv_text, csv_options)

puts "Making Users"
10.times do
  User.create(username: Faker::Internet.username,password: 'password', email: Faker::Internet.email)
  puts "#{User.last.email}"
end
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "Making Brands"
Brand.create(name: "BWS" ,logo: "")
Brand.create(name: "Liqourland" ,logo: "")
Brand.create(name: "Dan Murphy's" ,logo: "")
Brand.create(name: "First Choice" ,logo: "")

10.times do
  new_store = Store.new(latitude: rand(-37.84578..-37.77509) ,longitude: rand(144.97737..145.03860), brand_id: Brand.find_by(name: brands.sample).id)
  # new_store.brand_id = Brand.find_by(name: brands.sample).id
  new_store.name = "#{Faker::Company.name}'s #{Brand.find(new_store.brand_id).name}"
  new_store.save
end



# 24 pack beers
csv.each do |row|
  Drink.create(name: row['Name'], category: row['Category'],volume: row['Volume'],abv: row['ABV'])
  Product.create(drink_id: Drink.last.id ,size: 24)
  recent_shops = []
  10.times do
    Inventory.create(price: rand(40.00..65.00) ,store_id: ((Store.first.id..Store.last.id).reject { |i| recent_shops.include?(i) }).sample )
    InventoryProduct.create(inventory_id: Inventory.last.id, product_id: Product.last.id)
    puts "#{Product.last.size} pack of #{Drink.last.name} for $#{(Inventory.last.price)} at #{Store.find( Inventory.last.store_id).name}"
    recent_shops << Inventory.last.store_id
  end
  Product.create(drink_id: Drink.last.id ,size: 6)
  recent_shops = []
  10.times do
    Inventory.create(price: rand(18.00..26.00) ,store_id: ((Store.first.id..Store.last.id).reject { |i| recent_shops.include?(i) }).sample )
    InventoryProduct.create(inventory_id: Inventory.last.id, product_id: Product.last.id)
    puts "#{Product.last.size} pack of #{Drink.last.name} for $#{(Inventory.last.price)} at #{Store.find( Inventory.last.store_id).name}"
    recent_shops << Inventory.last.store_id
  end
end
