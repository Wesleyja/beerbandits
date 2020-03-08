require 'byebug'
require 'json'
require 'open-uri'
urls = ["lat=-37.813907&lon=144.96324",
 "lat=-37.904751&lon=145.162538",
 "lat=-37.777210&lon=145.120348",
 "lat=-37.724354&lon=144.990448",
 "lat=-37.748195&lon=144.871142",
 "lat=-37.819827&lon=144.795136"
]
urls.each_with_index do |latlong, index|
  url = "https://www.liquorland.com.au/api/FindClosest/ll?#{latlong}"
  sleep(rand(15..20))
  file = URI.open(url, "User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:73.0) Gecko/20100101 Firefox/73.0").read
  data_hash = JSON.parse(file)
  data_hash.each do |store|
    if Store.find_by(latitude: store["latitude"].to_f).nil?
      Store.create(latitude: store["latitude"].to_f,longitude: store["longitude"].to_f, brand_id: Brand.find_by(name: "Liqourland").id, name: "Liqourland #{store["storeName"]}" )
      puts "#{Store.last.name} created at Latitude: #{Store.last.latitude}, Longitude: #{Store.last.longitude}"
    end
  end
end
