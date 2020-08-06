class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  validates :first_name, presence: true, format: { /\A[一-龥ぁ-ん]+\z/ }
  validates :family_name, presence: true, format: { /\A[一-龥]+\z/ }
  validates :first_name_kana, presence: true, format: { /\A[ぁ-んー－]+\z/ }
  validates :family_name_kana, presence: true, format: { /\A[ぁ-んー－]+\z/ }
  validates :email, presence: true, uniqueness: true, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/ } 

  validates :password, presence: true, length: { minimum: 7 }
  validates :birthday, presence: true
  
end
