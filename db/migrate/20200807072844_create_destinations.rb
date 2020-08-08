class CreateDestinations < ActiveRecord::Migration[6.0]
  def change
     create_table :destinations do |t|
      t.string :first_name_destination,         null: false
      t.string :family_name_destination,        null: false
      t.string :first_name_destination_kana,    null: false
      t.string :family_name_destination_kana,    null: false
      t.integer :postcode,                      null: false
      t.integer :prefecture,                    null: false #都道府県
      t.string :city,                           null: false
      t.string :house_number,                   null: false
      t.string :building_name
      t.integer :phone_number,                  unique: true
      t.references :user, foreign_key: true,    null:false
      t.timestamps
    end
      
  end
end
