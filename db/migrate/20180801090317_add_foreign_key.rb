class AddForeignKey < ActiveRecord::Migration[5.0]
  def change
    add_column :addresses, :user_id, :integer
    add_column :addresses, :bike_station_id, :integer
  end
end
