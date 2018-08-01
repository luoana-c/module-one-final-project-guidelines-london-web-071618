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
      sign_in(user_name)
      enter_address
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
