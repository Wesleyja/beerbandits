class Store < ApplicationRecord
  belongs_to :user
  belongs_to :brand
  has_many :specials
  has_many :inventories
end
