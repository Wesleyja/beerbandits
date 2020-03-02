class Store < ApplicationRecord
  belongs_to :user, :brand
  has_many :specials, :inventories
end
