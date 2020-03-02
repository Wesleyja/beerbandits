class InventoryProduct < ApplicationRecord
  belongs_to :inventory
  belongs_to :product
end
