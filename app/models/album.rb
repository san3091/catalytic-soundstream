class Album < ApplicationRecord
  belongs_to :category
  belongs_to :curator
  acts_as_list scope: :category
end
