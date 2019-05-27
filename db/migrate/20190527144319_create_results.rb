class CreateResults < ActiveRecord::Migration[5.2]
  def change
    create_table :results do |t|
      t.resources :itinerary
      t.resources :event

      t.timestamps
    end
  end
end
