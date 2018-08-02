require_relative '../config/environment'
require_relative '../lib/CLI_methods.rb'


# puts "HELLO WORLD"

def run
  help
  user_input = ""
  while user_input
    puts "Please enter a command."
    user_input = gets.downcase.strip
    case user_input
    when "sign in"
      puts "Please enter your user name"
      user_name = gets.chomp.downcase
      user = sign_in(user_name)

      puts "Please choose from following options (enter a or b):
      a. Enter a new address
      b. Retrieve your saved addresses"

    when "a"
      puts "enter address"
      address_instance = enter_address(user)
      # new_address = gets.chomp.downcase
      # user.add_address_for_user(new_address)
      puts "Please choose from following options (enter c or d):
        c. Find the nearest bike station
        d. Find the nearest 3 bike stations"

    when "b"
      puts "These are your saved addresses:"
      user.all_addresses_for_user
      puts "Please enter an address"
      address_instance = enter_address(user)


    puts "Please choose from following options (enter c or d):
      c. Find the nearest bike station
      d. Find the nearest 3 bike stations"

    when "c"
      distance = address_instance.distance_to_nearest_bike_station
      nearest_bike_station = address_instance.find_bike_station(distance)
      puts "Your nearest bike station is #{nearest_bike_station.name}."

      puts "Please choose from following options (enter e or f):
      e. Find the number of available bikes at #{nearest_bike_station.name}
      f. Find the number of empty docks at #{nearest_bike_station.name}"
    when "d"
      puts "These are your 3 nearest stations:"
      address_instance.names_of_nearest3bike_stations
      puts "Please choose one and enter 1, 2 or 3."
    when "1"
    when "2"
    when "3"
    when "e"
      number_bikes = nearest_bike_station.number_bikes_available
      puts "The number of available bikes at #{nearest_bike_station.name} is #{number_bikes}."
    when "f"
      empty_docks = nearest_bike_station.number_empty_docks
      puts "The number of empty docks at #{nearest_bike_station.name} is #{empty_docks}."
    when "sign up"
      sign_up
    when "exit"
      exit
      break
    else
      help
    end
  end
end

run
