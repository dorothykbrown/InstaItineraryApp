class CreateItineraries < ActiveRecord::Migration[5.2]
  def change
    create_table :itineraries do |t|
      t.string :name
      t.string :events
      t.string :location
      t.integer :search_radius
      t.integer :available_time

      t.timestamps
    end
  end
end
