class Address < ActiveRecord::Base
  belongs_to :user
  belongs_to :bike_station

  def convert_address_to_coordinates
    #this converts the user address into coordinates, and this method is already called within the next ones, we don't need to call it in run
    results = Geocoder.search(self.address)
    results.first.coordinates
    # self.lat = results.first.coordinates[0]
    # self.long = results.first.coordinates[1]
  end

  def distances_to_all_bike_stations
    #this calculates distance from address to each bike station and returns array of distances
      BikeStation.all.map {|bike_station| Geocoder::Calculations.distance_between(convert_address_to_coordinates, [bike_station.lat,bike_station.long])}
  end

  def distance_to_nearest_bike_station
    #calls on method above and returns shortest distance between address and bike station
    minimum_distance = distances_to_all_bike_stations.min
  end

  def find_bike_station(distance)
    #distance argument is either calling on the distance to nearest bike station or nearest 3 distances to bike stations
    #returns an instance of a bike station
    BikeStation.all.find {|bike_station| Geocoder::Calculations.distance_between(convert_address_to_coordinates, [bike_station.lat,bike_station.long]) == distance}
  end

  def distance_to_nearest_three_bike_stations
    distances = distances_to_all_bike_stations.sort.shift(3)
  end
  def nearest_three_bike_stations
    #returns an array of 3 bike station instances
    ordered_dist = distance_to_nearest_three_bike_stations
    ordered_dist.map {|dist| find_bike_station(dist)}
  end

  def names_of_nearest3bike_stations
    nearest_three_bike_stations.map {|station|  station.name}
  end
end
