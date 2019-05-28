class AddCoordinatesToItineraries < ActiveRecord::Migration[5.2]
  def change
    add_column :itineraries, :latitude, :float
    add_column :itineraries, :longitude, :float
  end
end
