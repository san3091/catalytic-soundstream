class Album < ApplicationRecord
  belongs_to :category
  acts_as_list scope: :category
end
