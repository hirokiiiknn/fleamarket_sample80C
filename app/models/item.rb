class Item < ApplicationRecord
  belongs_to :category
  belongs_to :brand
  accepts_nested_attributes_for :brand
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true
  # accepts_nested_attributes_for :images
  #Itemモデルで 「購入者」「出品者」を取り出せるようにする。
  belongs_to :seller, class_name: "User"
  belongs_to :buyer, class_name: "User", optional: true


 
  validates :name,                         presence: true,    length: { maximum: 40 } 
  validates :introduction,             presence: true,    length: { maximum: 1000 } 
  validates :category_id,                     presence: true
  validates :item_condition,                  presence: true
  validates :quantity,               presence: true
  validates :cost,                 presence: true
  validates :prefecture,              presence: true
  validates :days,          presence: true
  validates :price,             presence: true
  # validates_associated :images
  # validates :image_id,                       presence: true
  # enum item_condition: {新品未、使用: 1, 未使用に近い: 2,目立った傷や汚れなし: 3,やや傷や汚れあり: 4,傷や汚れあり: 5,全体的に状態が悪い: 6}
  # enum delivery_fee: {送料込み（出品者負担）: 1, 着払い（購入者負担）: 2}
  # enum days: {１〜２日で発送: 1, ２〜３日で発送: 2, ４〜７日で発送: 2}
  

  extend ActiveHash::Associations::ActiveRecordExtensions
  # belongs_to_active_hash :category
  # belongs_to_active_hash :size
  belongs_to_active_hash :delivery_fee
  belongs_to_active_hash :prefecture_fire
  belongs_to_active_hash :delivery_days
  # belongs_to_active_hash :delivery_way
  belongs_to_active_hash :condition
end


