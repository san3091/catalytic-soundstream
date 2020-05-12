class Category < ApplicationRecord
  has_many :albums, dependent: :destroy
  require 'csv'

  def import_albums(file, insert_mode)
    order = set_order(insert_mode)
    albums = []
    CSV.foreach(file, headers: %w(artist title description curator bandcamp_url soundcloud_url)) do |row|
      albums << Album.new do |a|
        a.title           = row['title']
        a.arist           = row['artist']
        a.soundcloud_url  = row['soundcloud_url']
        a.bandcamp_url    = row['bandcamp_url']
        a.curator         = Curator.find_or_create_by(name: row['curator'])
        a.order           = order
        a.category        = self
      end
      order += 1
    end

    Album.import(albums, recursive: true)
  end

  private

  def set_order(insert_mode)
    self.albums.destroy_all if insert_mode == 'replace'
    self.albums.maximum(:order) || 0
  end

end
