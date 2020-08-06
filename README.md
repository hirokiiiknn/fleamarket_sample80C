  
## userテーブル

|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|first_name|string|null: false|
|family_name|string|null: false|
|first_name_kana|string|null: false|
|family_name_kana|string|null: false|
|email|string|null: false, unique: true, index:true|
|password|string|null: false|
|birthday|integer|null: false|
|introduction|text||
|avator|string||


### Association
- has_many :seller_items, foreign_key: "seller_id", class_name: "items"
- has_many :buyer_items, foreign_key: "buyer_id", class_name: "items"
- has_one: destination
- has_one: card

## destinationテーブル

|Column|Type|Options|
|------|----|-------|
|first_name_destination|string|null: false|
|family_name_destination|string|null: false|
|first_name_destination_kana|string|null: false|
|postcode|integer(7)|null: false|
|prefecture|integer|null: false|
|city|string|null: false, unique: true, index:true|
|house_number|string|null: false|
|building_name|string|
|phone_number|integer|unique: true|
|user_id|references|null:false, foreign_key: true|


### Association
- belongs_to: user

## cardsテーブル

|Column|Type|Options|
|------|----|-------|
|card_number|integer|null: false, unique: true|
|expiration_year|integer|null: false|
|expiration_month|integer|null: false|
|security_code|integer|null: false|
|user_id|references|null:false, foreign_key: true|


### Association
- belongs_to: user
- gem: jp_prefectureを使用する

## itemsテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|introduction|text|null: false|
|price|integer|null: false|
|brand_id|references|null:false, foreign_key: true|
|item_condition_id|references|null:false, foreign_key: true|
|prefecture_id|integer|null: false|
|size_id|references|null:false, foreign_key: true|
|cost|integer|null: false|
|days|integer|null: false|
|seller_id|references|null:false, foreign_key: true|
|buyer_id|references|foreign_key: true|
|category_id|references|null:false, foreign_key: true|


### Association
- belongs_to: brand
- belongs_to: category
- has_many: images
- belongs_to :seller, class_name: "User"
- belongs_to :buyer, class_name: "User"
- Gem：jp_prefectureを使用する
- 

## brandテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|



### Association
- has_many: items


## categoryテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|ancestry|string|null: false|



### Association
- has_many: items

## imagesテーブル

|Column|Type|Options|
|------|----|-------|
|image|string|null: false|
|item_id|references|null: false, foreign_key: true|



### Association
- belongs_to: items