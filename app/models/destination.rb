class Destination < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :card, optional: true

  validates :first_name_destination, :family_name_destination, :first_name_destination_kana, :family_name_destination_kana, :postcode, :prefecture, :city, :house_number, presence: true

  VALID_FIRSTNAME_REGEX = /\A[一-龥ぁ-ん]+\z/
  validates :first_name_destination, format: { with: VALID_FIRSTNAME_REGEX } 

  VALID_FAMIRYNAME_REGEX = /\A[一-龥]+\z/
  validates :family_name_destination, format: { with: VALID_FAMIRYNAME_REGEX } 

  VALID_KANA_REGEX = /\A[ぁ-んー－]+\z/
  validates :first_name_destination_kana, format: { with: VALID_KANA_REGEX }
  validates :family_name_destination_kana, format: { with: VALID_KANA_REGEX } 

  validates :phone_number, uniqueness: true, allow_blank: true

  
end
