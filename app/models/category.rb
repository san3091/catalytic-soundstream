require 'csv'

class Category < ApplicationRecord
  has_many :albums, -> { order("position ASC") }, dependent: :destroy
  has_many :album_uploads, dependent: :destroy

  def import_albums(file)
    album_upload = AlbumUpload.create(category: self)
    albums.destroy_all unless self.rotating

    CSV.foreach(file, headers: :first_row) do |row|
      new_album = Album.new do |a|
        a.title           = row['title']
        a.artist          = row['artist']
        a.description     = row['description']
        a.soundcloud_url  = row['soundcloud private share link']
        a.bandcamp_url    = row['bandcamp link']
        a.curator_id      = Curator.find_or_create_by(name: row['curator']).id
        a.category        = self
        a.album_upload    = album_upload
        a.current         = current?
      end

      new_album.save!
    end

  end

  def current?
    (['curated', 'label'].include? self.name) ? false : true
  end

end
