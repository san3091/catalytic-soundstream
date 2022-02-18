class Album < ApplicationRecord
  belongs_to :category
  belongs_to :curator
  belongs_to :album_upload
  acts_as_list scope: :category
end
