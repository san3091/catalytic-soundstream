# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

category_names = %w(history curated)
categories = category_names.map { |category| Category.create(name: category) }

order = 1
album_titles = %w(Argh Love Noise Tender)
sample_url = "this.is.fake/right"
curated = categories[1]
album_titles.map do |album_title| 
  album = Album.new(title: album_title, url: sample_url, order: order)
  curated.albums << album
  curated.save!
  album.save!
  order += 1
  puts "Album #{album_title} created"
end

puts "All's well"
