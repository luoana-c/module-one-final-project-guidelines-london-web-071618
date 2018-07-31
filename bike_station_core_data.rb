require 'xmlsimple'

 hash = XmlSimple.xml_in('livecyclehireupdates.xml')
 hash["station"][0]["name"]
 station_names = hash["station"].map {|item| item["name"]}
 puts station_lat = hash["station"].map {|item| item["lat"]}
 station_long = hash["station"].map {|item| item["long"]}
