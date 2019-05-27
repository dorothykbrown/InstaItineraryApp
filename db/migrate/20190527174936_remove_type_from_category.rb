class RemoveTypeFromCategory < ActiveRecord::Migration[5.2]
  def change
    remove_column :categories, :type, :string
  end
end
