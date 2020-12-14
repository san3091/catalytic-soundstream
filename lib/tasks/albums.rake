namespace :albums do
  desc 'Initialize albums current status, to be run ONCE and NEVER AGAIN'
  task :init_current => :environment do
    Category.transaction do
      Category.includes(:albums)
        .find_by(name: "curated")
        .albums
        .limit(30)
        .update(current: true)

      puts "album current flags initialized"

      Category.includes(:albums)
        .where(name: ["history", "catalytic"])
        .map do |category|
          category.albums.update(current: true)
        end

      puts "catalytic and history set to current"
    end
  end

  desc 'Rotate current albums for curated playlist. Run in cron.'
  task :daily_rotate => :environment do
    Category.transaction do
      timestamp = DateTime.now.strftime("%Y-%m-%dT%H:%M:%S.%6N ")

      rotating_categories = Category.includes(:albums).where(rotating: true)
      current = curated.albums.where(current: true)
      oldest_album = current.first
      oldest_album.update(current: false)
      puts "#{timestamp} album #{oldest_album.title} by #{oldest_album.artist} removed from current albums"

      new_album = current.last.lower_item
      new_album.update(current: true)
      puts "#{timestamp} album #{new_album.title} by #{new_album.artist} added to current albums"    end
  end
end
