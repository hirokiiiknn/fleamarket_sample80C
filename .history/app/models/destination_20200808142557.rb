class Destination < ApplicationRecord
  belongs_to :user, optional: true

  validates :first_name_destination, :family_name_destination, : 
  ,presence: true

end
