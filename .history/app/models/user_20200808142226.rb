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
  
end
