class Category < ApplicationRecord
  has_many :albums, dependent: :destroy
  require 'csv'

  def import_albums(file, insert_mode)
    order = set_order(insert_mode)
    albums = []
    CSV.foreach(file, headers: true) do |row|
      albums << Album.new(title: row[0], url: row[1], order: order, category: self)
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
