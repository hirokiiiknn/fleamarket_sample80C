class Destination < ApplicationRecord
  belongs_to :user, optional: true

  validates :first_name_destination, :family_name_destination, :first_name_destination_kana, :family_name_destination_kana, :postcode, :prefecture, :city,
  ,presence: true

end
