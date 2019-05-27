class CreateResults < ActiveRecord::Migration[5.2]
  def change
    create_table :results do |t|
      t.references :itinerary, foreign_key: true
      t.references :event, foreign_key: true

      t.timestamps
    end
  end
end
