class CreateBikeStation < ActiveRecord::Migration[5.0]
  def change
    create_table :bike_stations do |t|
      t.string :name
      t.float :lat
      t.float :long
    end
  end
end
