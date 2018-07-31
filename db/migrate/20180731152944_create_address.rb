class CreateAddress < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
     t.string :address
     t.float :lat
     t.float :long
   end
  end
end
