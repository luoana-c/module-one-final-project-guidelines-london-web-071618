class Address < ActiveRecord::Base
  belongs_to :user
  belongs_to :bike_station

  def convert_address_to_coordinates
    results = Geocoder.search(self.address)
    results.first.coordinates
    # self.lat = results.first.coordinates[0]
    # self.long = results.first.coordinates[1]
  end

  def distance_to
    distances_array = BikeStation.all.map {|bike_station| Geocoder::Calculations.distance_between(convert_address_to_coordinates, [bike_station.lat,bike_station.long])}
    minimum_distance = distances_array.min
    BikeStation.all.find {|bike_station| Geocoder::Calculations.distance_between(convert_address_to_coordinates, [bike_station.lat,bike_station.long]) == minimum_distance}
  end
end
