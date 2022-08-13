class Product < ApplicationRecord
  belongs_to :category
  validates :category_id, presence: true
  validates :name, presence: true, uniqueness: true,
  validates :description, presence: true
end
