# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
require 'faker'
require 'csv'
require 'open-uri'
require 'json'
require 'uri'
require 'net/http'
require "base64"

# require 'byebug'
categories = ["Lager", "IPA", "Pale Ale", "Cider"]
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
#---------------------NEVER DELETE STORES --ABSOLUTE PAIN TO SEED ------------------------------------------------
# puts "Destorying Stores"
# Store.destroy_all
# puts "Destorying Brands"
# Brand.destroy_all
#---------------------NEVER DELETE STORES --ABSOLUTE PAIN TO SEED ------------------------------------------------

# Examples:
# csv_options = { col_sep: ',', quote_char: '"', headers: :first_row }
brands = ["BWS", "Liqourland", "Dan Murphy's", "First Choice"]
# csv_text = File.read(Rails.root.join('lib', 'seeds', 'drinks.csv'))
# csv = CSV.parse(csv_text, csv_options)
puts "Making Users"
10.times do
  User.create(username: Faker::Internet.username,password: 'password', email: Faker::Internet.email)
  puts "#{User.last.email}"
end
file_paleale = File.read(Rails.root.join('lib', 'seeds', 'bws-pale-ale.json'))
file_lager = File.read(Rails.root.join('lib', 'seeds', 'bws-lager.json'))
file_ipa = File.read(Rails.root.join('lib', 'seeds', 'bws-ipa.json'))
file_cider = File.read(Rails.root.join('lib', 'seeds', 'bws-cider.json'))
bws_jsons = [file_lager, file_ipa, file_paleale, file_cider]
categories = ["Lager", "IPA", "Pale Ale", "Cider"]
bws_jsons.each_with_index do |url, index|
  data_hash = JSON.parse(url)
  data_hash["Bundles"].each do |beer|
    beer["Products"].each do |x|
    # if the value is true, then its the hash with the single unit bottle, which has the % and Brand and Volume
      if x["AdditionalDetails"][x["AdditionalDetails"].find_index { |i| i["Name"] == "productunitquantity" }]["Value"] == "1"
        if x["AdditionalDetails"].find_index { |i| i["Name"] == "liquorsize" }.nil?
          volume = x["PackageSize"].gsub(/\D/, "").to_i || 0
        else
          volume = x["AdditionalDetails"][x["AdditionalDetails"].find_index { |i| i["Name"] == "liquorsize" }]["Value"].gsub(/\D/, "").to_i
        end
        if x["AdditionalDetails"].find_index { |i| i["Name"] == "alcohol%" }.nil?
          abv = 0
        elsif x["AdditionalDetails"][x["AdditionalDetails"].find_index { |i| i["Name"] == "alcohol%" }]["Value"].gsub(/\D$/, "").to_f > 12.0
          x["AdditionalDetails"].find_index { |i| i["Name"] == "standarddrinks" }
        else
          abv = x["AdditionalDetails"][x["AdditionalDetails"].find_index { |i| i["Name"] == "alcohol%" }]["Value"].gsub(/\D$/, "").to_f
        end
        Drink.create(
        name: x["AdditionalDetails"][x["AdditionalDetails"].find_index { |i| i["Name"] == "product_short_name" }]["Value"],
        category: "#{categories[index]}",
        volume: volume,
        abv: abv
        )
        puts "Drink = #{Drink.last.name}"
        # Category = x["AdditionalDetails"][x["AdditionalDetails"].find_index { |i| i["Name"] == "liquorstyle" }]["Value"]
        # Brand = x["AdditionalDetails"][x["AdditionalDetails"].find_index { |i| i["Name"] == "brand_name" }]["Value"]
      end
    end

    puts "Making Products"

    beer["Products"].each do |x|
      # if Drink.find_by(product_number: #value ).nil? -> then add new product / otherwise update
      if x["AdditionalDetails"][x["AdditionalDetails"].find_index { |i| i["Name"] == "productunitquantity" }]["Value"].empty?
        size = x["AdditionalDetails"][x["AdditionalDetails"].find_index { |i| i["Name"] == "displayunitquantity" }]["Value"].to_i
      else
        size = x["AdditionalDetails"][x["AdditionalDetails"].find_index { |i| i["Name"] == "productunitquantity" }]["Value"].to_i
      end
      if x["AdditionalDetails"][x["AdditionalDetails"].find_index { |i| i["Name"] == "webpacktype" }]["Value"] == "Case" && x["AdditionalDetails"][x["AdditionalDetails"].find_index { |i| i["Name"] == "productunitquantity" }]["Value"] == "1"
        size = x["AdditionalDetails"][x["AdditionalDetails"].find_index { |i| i["Name"] == "displayunitquantity" }]["Value"].to_i
      end
      Product.create(drink_id: Drink.last.id, size: size)
      stores = Store.where(brand_id: Brand.find_by(name: 'BWS')).ids
      stores.each do |id|
        Inventory.create(price: x["Price"], store_id: id)
        InventoryProduct.create(inventory_id: Inventory.last.id, product_id: Product.last.id)
        puts "#{Product.last.size} pack of #{Drink.last.name} for $#{(Inventory.last.price)} at #{Store.find( Inventory.last.store_id).name}"
      end
    end
  end
end
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# puts "Making Brands"
# Brand.create(name: "BWS" ,logo: "")
# Brand.create(name: "Liqourland" ,logo: "")
# Brand.create(name: "Dan Murphy's" ,logo: "")
# Brand.create(name: "First Choice" ,logo: "")

# 10.times do
#   new_store = Store.new(latitude: rand(-37.84578..-37.77509) ,longitude: rand(144.97737..145.03860), brand_id: Brand.find_by(name: brands.sample).id)
#   # new_store.brand_id = Brand.find_by(name: brands.sample).id
#   new_store.name = "#{Faker::Company.name}'s #{Brand.find(new_store.brand_id).name}"
#   new_store.save
# end

# # 24 pack beers
# csv.each do |row|
#   Drink.create(name: row['Name'], category: row['Category'],volume: row['Volume'],abv: row['ABV'])
#   Product.create(drink_id: Drink.last.id ,size: 24)
#   recent_shops = []
#   10.times do
#     Inventory.create(price: rand(40.00..65.00) ,store_id: ((Store.first.id..Store.last.id).reject { |i| recent_shops.include?(i) }).sample )
#     InventoryProduct.create(inventory_id: Inventory.last.id, product_id: Product.last.id)
#     puts "#{Product.last.size} pack of #{Drink.last.name} for $#{(Inventory.last.price)} at #{Store.find( Inventory.last.store_id).name}"
#     recent_shops << Inventory.last.store_id
#   end
#   Product.create(drink_id: Drink.last.id ,size: 6)
#   recent_shops = []
#   10.times do
#     Inventory.create(price: rand(18.00..26.00) ,store_id: ((Store.first.id..Store.last.id).reject { |i| recent_shops.include?(i) }).sample )
#     InventoryProduct.create(inventory_id: Inventory.last.id, product_id: Product.last.id)
#     puts "#{Product.last.size} pack of #{Drink.last.name} for $#{(Inventory.last.price)} at #{Store.find( Inventory.last.store_id).name}"
#     recent_shops << Inventory.last.store_id
#   end
# end




