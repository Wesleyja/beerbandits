class Inventory < ApplicationRecord
  belongs_to :store
  monetize :price_cents
end
