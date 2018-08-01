def help
  puts "I accept the following commands:
  - sign in: allows existing user to sign back into the account
  - sign up: create a new user ID
  - exit: exits this program"
end

def sign_up
  puts "Please enter a user name"
  user_name = gets.chomp.downcase
  if User.all.find{|user| user.name == user_name}
    puts "User name already exists, please choose a different one or sign in."
  else
    User.create(:name => user_name)
    puts "User #{user_name} has been created."
  end
end

def sign_in(user_name)

  if !User.all.find{|user| user.name == user_name}
    puts "User name not found, please sign up."
  else
    User.all.find{|user| user.name == user_name}
  end
end

def enter_address
  puts "please enter an address"
  user_address = gets.chomp.downcase
  address = Address.all.find {|address| address.address == user_address}
  if !address
    address = Address.create(address: user_address, user_id: sign_in.id)
  end
  puts address.distance_to.name
end

def exit
  puts "Goodbye!"
end
