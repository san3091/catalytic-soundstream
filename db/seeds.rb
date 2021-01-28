Rails.application.load_tasks

category_names = %w(history curated catalytic label)
categories = category_names.map { |category| Category.find_or_create_by(name: category) }
puts "Created categories #{category_names.join(", ")}"

# admin = Admin.create!(name: "admin", email: Rails.application.credentials.admin_email, password: Rails.application.credentials.admin_password)
# puts 'Created sample admin'

categories.map { |category| category.import_albums("lib/#{category.name}.csv", 'replace') }
puts 'Added seed albums to categories'

Daddy.import_daddies('lib/grandfathered_users.csv')
puts "Added #{Daddy.count} grandfathered users"

Rake::Task["albums:init_current"].invoke
