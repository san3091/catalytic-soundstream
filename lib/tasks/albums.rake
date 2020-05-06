namespace :albums do
  desc 'Populate database from csv file'
  task :bulk_import, [:category] => [:environment] do |t, args|
    category = Category.find_or_create_by(name: args.category)
    # TODO switch on a flag replace/append and make sure album order logic knows this
    Album.transaction do
      category.albums.destroy_all
      beginning_order = Album.all.order(:order).last.order + 1

      category.import_albums("lib/#{args.category}.csv", beginning_order)
      Album.where(order: [beginning_order..beginning_order + 30]).update(current: true)
    end
  end

  desc 'Initialize albums current status, to be run ONCE and NEVER AGAIN'
  task :init_current => :environment do
    categories = Category.includes(:albums)
    categories.map do |category|
      albums = category.albums.where(order: [0...30]).each { |album| album && album.update!(current: true) }
      albums.map(&:save!)
    end
    p "album current flags initialized"
  end

  desc 'Rotate current albums for curated playlist. Run in cron.'
  task :daily_rotate => :environment do
    curated = Category.includes(:albums).find_by(name: "Curated")
    current_albums = curated.albums.where(current: true).order(:order)
    oldest_album = current_albums.first
    oldest_album.update(current: false)
    p "album #{oldest_album.name} removed from current albums"

    new_album = curated.albums.where(order: current_albums.last.order + 1)
    new_album.update(current: true)
    p "album #{new_album.name} added to current albums"
  end
end
