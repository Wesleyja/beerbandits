postcodes = ["3121", "3141", "3142", "3122", "3101", "3068", "3066", "3067", "3002" ]
file = File.read(Rails.root.join('lib', 'seeds', 'll-locations.json'))
data_hash = JSON.parse(file)
data_hash.each do |store|
  if Store.find_by(latitude: store["latitude"].to_f).nil? && postcodes.include?(store["postcode"])
    Store.create(latitude: store["latitude"].to_f,longitude: store["longitude"].to_f, brand_id: Brand.find_by(name: "Liqourland").id, name: "Liqourland #{store["storeName"]}" )
    puts "#{Store.last.name} created at Latitude: #{Store.last.latitude}, Longitude: #{Store.last.longitude}"
  end
end
file = File.read(Rails.root.join('lib', 'seeds', 'fc-locations.json'))
data_hash = JSON.parse(file)
data_hash.each do |store|
  if Store.find_by(latitude: store["latitude"].to_f).nil? && postcodes.include?(store["postcode"])
    Store.create(latitude: store["latitude"].to_f,longitude: store["longitude"].to_f, brand_id: Brand.find_by(name: "First Choice").id, name: "First Choice #{store["storeName"]}" )
    puts "#{Store.last.name} created at Latitude: #{Store.last.latitude}, Longitude: #{Store.last.longitude}"
    postcodes << store["postcode"]
  end
end
file = File.read(Rails.root.join('lib', 'seeds', 'bws-locations.json'))
data_hash = JSON.parse(file)
data_hash["Stores"].each do |store|
  if postcodes.include?(store["Postcode"])
    store_name = store["Name"]
    Store.create(latitude: store["Latitude"].to_f,longitude: store["Longitude"].to_f, brand_id: Brand.find_by(name: "BWS").id, name: "BWS #{store_name}" )
    puts "#{Store.last.name} created at Latitude: #{Store.last.latitude}, Longitude: #{Store.last.longitude}"
  end
end
file = File.read(Rails.root.join('lib', 'seeds', 'danmurphys-location.json'))
data_hash = JSON.parse(file)
data_hash["Stores"].each do |store|
  if postcodes.include?(store["Postcode"])
    store_name = store["Name"]
    Store.create(latitude: store["Latitude"].to_f,longitude: store["Longitude"].to_f, brand_id: Brand.find_by(name: "Dan Murphy's").id, name: "Dan Murphy's #{store_name}" )
    puts "#{Store.last.name} created at Latitude: #{Store.last.latitude}, Longitude: #{Store.last.longitude}"
  end
end


