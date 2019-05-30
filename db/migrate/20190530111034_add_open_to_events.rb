class AddOpenToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :open_now, :boolean
  end
end
