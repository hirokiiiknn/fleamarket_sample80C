class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.text :introduction, null: false
      t.integer :price, null: false
      # t.references :brand,  null: false, foreign_key: true
      # t.references :item_dondition, null: false, foreign_key: true
      t.integer :prefecture, null: false
      # t.references :size, null:  false, foreign_key: true
      t.integer :cost, null: false
      t.integer :days, null: false
      # t.references :seller, null: false, foreign_key: true
      # t.references :buyer,  foreign_key: true
      # t.references :category, null: false, foreign_key: true
      t.timestamps
    end
  end
end
