class Item < ApplicationRecord
  belongs_to :category
  belongs_to :brand
  accepts_nested_attributes_for :brand, allow_destroy: true
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true
  #Itemモデルで 「購入者」「出品者」を取り出せるようにする。
  belongs_to :seller, class_name: "User"
  belongs_to :buyer, class_name: "User", optional: true
  belongs_to :card

 
  validates :name,                         presence: true,    length: { maximum: 40 } 
  validates :introduction,             presence: true,    length: { maximum: 1000 } 
  validates :category_id,                     presence: true
  validates :item_condition,                  presence: true
  validates :quantity,               presence: true
  validates :cost,                 presence: true
  validates :prefecture,              presence: true
  validates :days,          presence: true
  validates :price,             presence: true, numericality: {greater_than_or_equal_to: 300}
  validates :images, presence: true
  

  extend ActiveHash::Associations::ActiveRecordExtensions
  # belongs_to_active_hash :category
  # belongs_to_active_hash :size
  belongs_to_active_hash :delivery_fee
  belongs_to_active_hash :prefecture_fire
  belongs_to_active_hash :delivery_days
  belongs_to_active_hash :condition
end


