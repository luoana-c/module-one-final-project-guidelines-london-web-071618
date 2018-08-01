require 'xmlsimple'
BikeStation.delete_all

 hash = XmlSimple.xml_in('livecyclehireupdates.xml')
 hash["station"][0]["name"]
 station_names = hash["station"].map {|item| item["name"][0]}
 station_lat = hash["station"].map {|item| item["lat"][0]}
 station_long = hash["station"].map {|item| item["long"][0]}

 index_array = (0..station_names.length-1).to_a

 index_array.each do |i|
   BikeStation.create(:name => station_names[i], :lat => station_lat[i], :long => station_long[i])
 end
