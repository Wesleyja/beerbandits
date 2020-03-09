require 'byebug'
require 'json'
require 'open-uri'

file = URI.open("https://api.bws.com.au/apis/ui/StoreLocator/Stores/bws?state=VIC&type=allstores").read
data_hash = JSON.parse(file)
data_hash["Stores"].each do |store|
  store_name = store["Name"]
  Store.create(latitude: store["Latitude"].to_f,longitude: store["Longitude"].to_f, brand_id: Brand.find_by(name: "BWS").id, name: "BWS #{store_name}" )
  puts "#{Store.last.name} created at Latitude: #{Store.last.latitude}, Longitude: #{Store.last.longitude}"
end

