class CreateUserLocations < ActiveRecord::Migration
  def change
    create_table :user_locations do |t|
      t.references :user, index: true
      t.string :latitude
      t.string :longitude

      t.timestamps
    end
  end
end

