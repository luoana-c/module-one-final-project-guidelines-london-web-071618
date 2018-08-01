class User < ActiveRecord::Base
  has_many :addresses
  has_many :bike_stations, through: :addresses
end
