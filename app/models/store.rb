class Store < ApplicationRecord
  belongs_to :user, required: false
  belongs_to :brand
  has_many :specials
  has_many :inventories
end
