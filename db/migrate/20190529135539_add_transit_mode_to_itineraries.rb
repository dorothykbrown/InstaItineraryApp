class AddTransitModeToItineraries < ActiveRecord::Migration[5.2]
  def change
    add_column :itineraries, :transit_mode, :string
  end
end
