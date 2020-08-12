class AddBrandIdToItem < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :brand_id, :string
  end
end
