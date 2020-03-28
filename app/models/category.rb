class Category < ApplicationRecord
  has_many :albums, dependent: :destroy
  require 'csv'

  def import_albums(file, beginning_order)
    order = beginning_order
    albums = []
    CSV.foreach(file, headers: true) do |row|
      albums << Album.new(title: row[0], url: row[1], order: order, category: self)
      order += 1
    end

    Album.import(albums, recursive: true)
  end
end
