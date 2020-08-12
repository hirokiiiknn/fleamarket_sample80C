class AddItemIdToImages < ActiveRecord::Migration[6.0]
  def change
    add_column :images, :item_id, :integer
  end
end
