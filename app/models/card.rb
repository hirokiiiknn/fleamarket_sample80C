class Card < ApplicationRecord
  belongs_to :user
  has_one :destination  

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :year
  belongs_to_active_hash :month
end

