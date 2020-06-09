require 'csv'

class Category < ApplicationRecord
  has_many :albums, -> { order("position ASC") }

  def import_albums(file, insert_mode)
    albums = []
    CSV.foreach(file, headers: :first_row) do |row|
      new_album = Album.new do |a|
        a.title           = row['title']
        a.artist          = row['artist']
        a.description     = row['description']
        a.soundcloud_url  = row['soundcloud private share link']
        a.bandcamp_url    = row['bandcamp link']
        a.curator_id      = Curator.find_or_create_by(name: row['curator']).id
        a.category        = self
        a.current         = self.name == 'curated' ? false : true
      end

      new_album.save!
    end

  end

end
