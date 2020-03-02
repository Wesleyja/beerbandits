class Product < ApplicationRecord
  belongs_to :drink
  has_many :inventory_products
  has_many :inventories, through: :inventory_products
end
