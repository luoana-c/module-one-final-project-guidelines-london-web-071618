class BikeStation < ActiveRecord::Base
  has_many :addresses
  has_many :users, through: :addresses
  has_one :bike_stations_status


end
