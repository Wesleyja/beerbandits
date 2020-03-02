class Inventory < ApplicationRecord
  monetize :price_cents
  belongs_to :store
  has_many :inventory_products
  has_many :products, through: :inventory_products
end
