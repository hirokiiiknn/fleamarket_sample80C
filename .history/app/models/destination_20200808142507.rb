class Destination < ApplicationRecord
  belongs_to :user, optional: true

  validates :first_name_destination, :age ,presence: true

end
