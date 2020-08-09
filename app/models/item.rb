class Item < ApplicationRecord

  belongs_to :category
  # belongs_to :brand
  has_many :images
  belongs_to :seller, class_name: "User"
  belongs_to :buyer, class_name: "User"
end


