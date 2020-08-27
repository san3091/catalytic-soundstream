namespace :one_offs do
  desc "add label radio category and seed"
  task create_label_category: :environment do
    label = Category.create!(name: "label", rotating: true)
    puts "label category created"

    Album.transaction do
      label.import_albums("lib/label.csv", "replace")
      puts label.albums.count
      puts "label albums imported"
      label.albums.limit(30).update(current: true)
      puts "label current flags initialized"
    end

    puts "we're done sis!"
  end
end
