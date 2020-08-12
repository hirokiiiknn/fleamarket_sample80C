class RemoveItemIdFromImages < ActiveRecord::Migration[6.0]
  def change
    remove_column :images, :item_id, :integer
  end
end
