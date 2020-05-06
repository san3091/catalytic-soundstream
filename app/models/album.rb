class Album < ApplicationRecord
  belongs_to :category
  validates :order, uniqueness: { scope: :category }
end
