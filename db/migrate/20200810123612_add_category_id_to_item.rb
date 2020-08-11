class AddCategoryIdToItem < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :category_id, :string
  end
end
