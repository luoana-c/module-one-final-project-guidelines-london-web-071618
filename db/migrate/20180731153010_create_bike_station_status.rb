class CreateBikeStationStatus < ActiveRecord::Migration[5.0]
  def change
    create_table :bike_stations_status do |t|
     t.integer :num_bikes_available
     t.integer :num_empty_docks
   end
  end
end
