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
end
