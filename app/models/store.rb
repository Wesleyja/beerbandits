class Store < ApplicationRecord
  belongs_to :user, required: false
  belongs_to :brand
  has_many :specials
  has_many :inventories
  has_many :products, through: :inventories
  has_many :drinks, through: :products
end
