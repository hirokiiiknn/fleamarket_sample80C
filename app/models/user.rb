class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  validates :first_name, presence: true#,  format: { /\A[一-龥ぁ-ん]+\z/ } エラー原因の為コメントアウト中
  validates :family_name, presence: true#, format: { /\A[一-龥]+\z/ } エラー原因の為コメントアウト中
  validates :first_name_kana, presence: true#, format: { /\A[ぁ-んー－]+\z/ }エラー原因の為コメントアウト中
  validates :family_name_kana, presence: true#, format: { /\A[ぁ-んー－]+\z/ } エラー原因の為コメントアウト中
  validates :email, presence: true, uniqueness: true#, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/ } エラー原因の為コメントアウト中
  validates :password, presence: true, length: { minimum: 7 }
  validates :birthday, presence: true
  
end
