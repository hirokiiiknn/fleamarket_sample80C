class AddItemConditionToItem < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :item_condition, :integer
  end
end
