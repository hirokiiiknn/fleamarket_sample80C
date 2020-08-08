class Destination < ApplicationRecord
  belongs_to :user, optional: true

  validates :first_name_destination, :family_name_destination, :first_name_destination_kana, :family_name_destination_kana, :postcode, :prefecture, :city, :house_number, :user_id ,presence: true

  VALID_FIRSTNAME_REGEX = /\A[一-龥ぁ-ん]+\z/
  validates :first_name, presence: true, format: { with: VALID_FIRSTNAME_REGEX } 

  VALID_FAMIRYNAME_REGEX = /\A[一-龥]+\z/
  validates :family_name, presence: true, format: { with: VALID_FAMIRYNAME_REGEX } 

  VALID_KANA_REGEX = /\A[ぁ-んー－]+\z/
  validates :first_name_kana, presence: true, format: { with: VALID_KANA_REGEX }
  validates :family_name_kana, presence: true, format: { with: VALID_KANA_REGEX } 

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX } 

end
