class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :name
      t.integer :duration
      t.text :description
      t.string :address
      t.integer :rating
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
