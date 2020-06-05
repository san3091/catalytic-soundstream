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
    Category
      .includes(:albums)
      .find_by(name: "curated")
      .albums
      .limit(30)
      .update(current: true)

    puts "album current flags initialized"
  end

  desc 'Rotate current albums for curated playlist. Run in cron.'
  task :daily_rotate => :environment do
    curated = Category.includes(:albums).find_by(name: "curated")
    current = curated.albums.where(current: true)
    oldest_album = current.first
    oldest_album.update(current: false)
    puts "album #{oldest_album.title} by #{oldest_album.artist} removed from current albums"

    new_album = current.last.lower_item
    new_album.update(current: true)
    puts "album #{new_album.title} by #{new_album.artist} added to current albums"
  end
end
