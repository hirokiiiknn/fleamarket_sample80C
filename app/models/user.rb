class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  validates :nickname, presence: true

  VALID_FIRSTNAME_REGEX = /\A[一-龥ぁ-ん]+\z/
  validates :first_name, presence: true, format: { with: VALID_FIRSTNAME_REGEX } 

  VALID_FAMIRYNAME_REGEX = /\A[一-龥]+\z/
  validates :family_name, presence: true, format: { with: VALID_FAMIRYNAME_REGEX } 

  VALID_KANA_REGEX = /\A[ぁ-んー－]+\z/
  validates :first_name_kana, presence: true, format: { with: VALID_KANA_REGEX }
  validates :family_name_kana, presence: true, format: { with: VALID_KANA_REGEX } 

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX } 


  validates :password, presence: true, length: { minimum: 7 }
  validates :birthday, presence: true

  has_one :destination
  has_one :card
  
  #Userモデルで「買った商品」「現在売っている商品」「既に売った商品」を取り出せるようにする。
  #userが「買った」商品 →bought_items
  has_many :bought_items, foreign_key: "buyer_id", class_name: "Item" 
  #userが 「現在売っている」商品 →selling_items
  has_many :selling_items, -> { where("buyer_id is NULL") }, foreign_key: "seller_id", class_name: "Item"
  #userが「既に売った」商品 →sold_items
  has_many :sold_items, -> { where("buyer_id is not NULL") }, foreign_key: "seller_id", class_name: "Item"
end
