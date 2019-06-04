class DropEventReviewsTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :event_reviews
  end
end
