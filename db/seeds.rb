# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

category_names = %w(history curated catalytic)
categories = category_names.map { |category| Category.create(name: category) }
puts "Created categories #{category_names.join(" ")}"

admin = Admin.create(name: "admin", email: Rails.application.credentials.admin_email, password: Rails.application.credentials.admin_password)
puts 'Created sample admin'

categories.map { |category| category.import_albums("lib/#{category.name}csv", 'replace') }
puts 'Added seed albums to categories'

Daddy.import_daddies('lib/gradfathered_users.csv')
puts "Added #{Daddy.count} gradfathered users"
