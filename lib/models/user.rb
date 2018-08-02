class User < ActiveRecord::Base
  has_many :addresses
  has_many :bike_stations, through: :addresses

  def all_addresses_for_user

    address_instances = Address.all.select{|address| address.user_id == self.id}
    address_instances.each{|address| puts address.address}
  end

  def add_address_for_user(new_address)
    Address.create(address: new_address, user_id: self.id)
  end


end
