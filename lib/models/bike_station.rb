require 'rest-client'

class BikeStation < ActiveRecord::Base
  has_many :addresses
  has_many :users, through: :addresses
  has_one :bike_stations_status

  def bike_station_status
    hash = RestClient.get('https://tfl.gov.uk/tfl/syndication/feeds/cycle-hire/livecyclehireupdates.xml')
    formatted_hash = XmlSimple.xml_in(hash)
    found = []
    formatted_hash["station"].find {|station| station["name"][0] == self.name}
  end
  def number_bikes_available
    self.bike_station_status["nbBikes"][0]
  end

  def number_empty_docks
    self.bike_station_status["nbEmptyDocks"][0]
  end

end
