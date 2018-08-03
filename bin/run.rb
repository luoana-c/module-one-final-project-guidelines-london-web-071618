require_relative '../config/environment'
require_relative '../lib/CLI_methods.rb'
require 'rainbow'


# puts "HELLO WORLD"

def run
  puts Rainbow("Hello, welcome to Santander Cycles app!").magenta
  help
  user_input = ""
  while user_input
    puts Rainbow("------------------").blue
    puts Rainbow("Enter a command:").blue
    user_input = gets.downcase.strip
    case user_input
    when "sign in"
      puts Rainbow("Please enter your user name:").blue
      user_name = gets.chomp.downcase
      user = sign_in(user_name)
      puts Rainbow("------------------").blue
      puts Rainbow("Please choose from following options (enter a or b):
      a. Enter a new address
      b. Retrieve your saved addresses").blue

    when "a"
      puts Rainbow("Enter address:").blue
      user_address = gets.chomp.downcase
      begin
        address_instance = enter_address(user, user_address)
      rescue
        puts Rainbow("I had some issue accessing the database, please try again.").red
      else
        address_instance
      end
      if !address_instance
      puts Rainbow("Please choose from following options (enter a or b):
      a. Enter a new address
      b. Retrieve your saved addresses").blue
        next
      end
      # new_address = gets.chomp.downcase
      # user.add_address_for_user(new_address)

      puts Rainbow("------------------").blue
      puts Rainbow("Please choose from following options (enter c or d):
        c. Find the nearest bike station
        d. Find the nearest 3 bike stations").blue

    when "b"
      puts Rainbow("These are your saved addresses:").green
      user.all_addresses_for_user
      puts Rainbow("------------------").blue
      puts Rainbow("Please enter an address:").blue
      user_address = gets.chomp.downcase
      address_instance = enter_address(user, user_address)
      if !address_instance
      puts Rainbow("Please choose from following options (enter a or b):
      a. Enter a new address
      b. Retrieve your saved addresses").blue
        next
      end
      puts Rainbow("------------------").blue
      puts Rainbow("Please choose from following options (enter c or d):
        c. Find the nearest bike station
        d. Find the nearest 3 bike stations").blue

    when "c"
      puts Rainbow("Please wait while I find your nearest bike station...
      ").blue
      distance = address_instance.distance_to_nearest_bike_station
      nearest_bike_station = address_instance.find_bike_station(distance)
      puts Rainbow("Your nearest bike station is: #{nearest_bike_station.name} (#{distance.round(2)} miles).").green
      puts Rainbow("------------------").blue
      puts Rainbow("Please choose from following options (enter e or f):
      e. Find the number of available bikes at #{nearest_bike_station.name}
      f. Find the number of empty docks at #{nearest_bike_station.name}").blue

    when "d"
      puts Rainbow("Please wait while I find your nearest bike stations...
        ").blue
      distances = address_instance.distance_to_nearest_three_bike_stations
      three_addresses = address_instance.nearest_three_bike_stations
      puts Rainbow("These are your nearest 3 stations:").green
      three_addresses.each_with_index {|station, index| puts Rainbow("#{index + 1}. #{station.name} (#{distances[index].round(2)} miles)").green}
      puts Rainbow("------------------").blue
      puts Rainbow("Please choose one and enter 1, 2 or 3.").blue
    when "1"
      puts Rainbow("Please choose from following options (enter e or f):
      e. Find the number of available bikes at #{nearest_bike_station.name}
      f. Find the number of empty docks at #{nearest_bike_station.name}").blue
      nearest_bike_station = three_addresses[0]

    when "2"
      puts Rainbow("Please choose from following options (enter e or f):
      e. Find the number of available bikes at #{nearest_bike_station.name}
      f. Find the number of empty docks at #{nearest_bike_station.name}").blue
      nearest_bike_station = three_addresses[1]

    when "3"
      puts Rainbow("Please choose from following options (enter e or f):
      e. Find the number of available bikes at #{nearest_bike_station.name}
      f. Find the number of empty docks at #{nearest_bike_station.name}").blue
      nearest_bike_station = three_addresses[2]

    when "e"
      number_bikes = nearest_bike_station.number_bikes_available
      puts Rainbow("The number of available bikes at #{nearest_bike_station.name} is #{number_bikes}.").green
    when "f"
      empty_docks = nearest_bike_station.number_empty_docks
      puts Rainbow("The number of empty docks at #{nearest_bike_station.name} is #{empty_docks}.").green
    when "sign up"
      sign_up
    when "exit"
      exit
      break
    else
      puts Rainbow("
        Sorry, I don't understand. Please try again.").red
      help
    end
  end
end

run
