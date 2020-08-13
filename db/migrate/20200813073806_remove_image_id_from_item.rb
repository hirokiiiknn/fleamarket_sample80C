class RemoveImageIdFromItem < ActiveRecord::Migration[6.0]
  def change
    remove_column :items, :image_id, :integer
  end
end
