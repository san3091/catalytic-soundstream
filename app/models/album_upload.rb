class AlbumUpload < ApplicationRecord
  belongs_to :category
  has_many :albums
end
