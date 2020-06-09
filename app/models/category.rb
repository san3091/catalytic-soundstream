require 'csv'

class Category < ApplicationRecord
  has_many :albums, -> { order("position ASC") }

  def import_albums(file, insert_mode)
    albums = []
    CSV.foreach(file, headers: %w(artist title description curator bandcamp_url soundcloud_url)) do |row|
      albums << Album.new do |a|
        a.title           = row['title']
        a.artist          = row['artist']
        a.description     = row['description']
        a.soundcloud_url  = row['soundcloud_url']
        a.bandcamp_url    = row['bandcamp_url']
        a.curator_id      = Curator.find_or_create_by(name: row['curator']).id
        a.category        = self
      end
    end

    Album.import!(albums, recursive: true)
  end

end
