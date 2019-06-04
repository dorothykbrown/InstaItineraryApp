class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.string :author
      t.string :content
      t.integer :rating
      t.string :date

      t.timestamps
    end
  end
end
