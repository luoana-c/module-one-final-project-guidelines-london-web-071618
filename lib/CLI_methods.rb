require 'rainbow'

def help
  puts Rainbow("
  I accept the following commands:
  - sign in: allows existing user to sign back into the account
  - sign up: create a new user ID
  - exit: exits this program").blue
end

def sign_up
  puts Rainbow("Please enter a user name:").blue
  user_name = gets.chomp.downcase
  if User.all.find{|user| user.name == user_name}
    puts Rainbow("User name already exists, please choose a different one or sign in.").red
  else
    User.create(:name => user_name)
    puts Rainbow("User #{user_name} has been created. Please sign in now.").green
  end
end

def sign_in(user_name)
  user = User.find_by(name: user_name)
  # {|user| user.name == user_name}

  if !user
    puts Rainbow("User name not found, please sign up.").red
  else
    user
  end
end


def enter_address(user, user_address)
  address =Address.all.find{|address| address.user_id == user.id && address.address == user_address}
  # address = user_addresses.find {|address| address.address == user_address}
  if !address
    address = Address.create(address: user_address, user_id: user.id)
    begin
      address.convert_address_to_coordinates
    rescue
      puts Rainbow("I cannot find this address, please check your spelling and try again.").red
      address.destroy
      return false
    else
      address
    end
  end
  address
  # address = Address.all.find {|address| address.address == user_address}
  # if !address
  #   address = Address.create(address: user_address, user_id: user.id)
  # end
  # address
end

def exit
  puts Rainbow("Goodbye!").blue
end
