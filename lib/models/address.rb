class Address < ActiveRecord::Base
  belongs_to :user
  belongs_to :bike_station

  def convert_address_to_coordinates
    results = Geocoder.search(self.address)
    results.first.coordinates
    # self.lat = results.first.coordinates[0]
    # self.long = results.first.coordinates[1]
  end

  def distances_to_all_bike_stations
    BikeStation.all.map {|bike_station| Geocoder::Calculations.distance_between(convert_address_to_coordinates, [bike_station.lat,bike_station.long])}
  end

  def nearest_bike_station
    minimum_distance = distances_to_all_bike_stations.min
  end

  def find_bike_station(distance)
    BikeStation.all.find {|bike_station| Geocoder::Calculations.distance_between(convert_address_to_coordinates, [bike_station.lat,bike_station.long]) == distance}
  end

  def nearest_three_bike_stations
    ordered_dist = distances_to_all_bike_stations.sort.shift(3)
    ordered_dist.map {|dist| find_bike_station(dist).name}
  end
end
