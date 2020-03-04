require 'byebug'
require 'json'
file = File.read(Rails.root.join('lib', 'seeds', 'bws-locations.json'))
data_hash = JSON.parse(file)
data_hash["Stores"].each do |store|
  store_name = store["Name"]
  Store.create(latitude: store["Latitude"].to_f,longitude: store["Longitude"].to_f, brand_id: Brand.find_by(name: "BWS").id, name: "BWS #{store_name}" )
  puts "#{Store.last.name} created at Latitude: #{Store.last.latitude}, Longitude: #{Store.last.longitude}"
end



