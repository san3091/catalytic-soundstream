# soundcloud_urls = [
#   'https://soundcloud.com/user-861231864/sets/streaming-test-1/s-q4DAH',
#   'https://soundcloud.com/playlist/sets/love-hurts',
#   'https://soundcloud.com/soundcloud-hustle/sets/hip-hop-party-starters',
#   'https://soundcloud.com/soundcloud-hustle/sets/hip-hop-love-songs',
#   'https://soundcloud.com/soundcloud-hustle/sets/mac-millers-definitive-1',
#   'https://soundcloud.com/soundcloud-shine/sets/chill-pop',
#   'https://soundcloud.com/soundcloud-shine/sets/playback-2019',
#   'https://soundcloud.com/soundcloud-shine/sets/2019-shine-playback',
#   'https://soundcloud.com/badbunny15/sets/yhlqmdlg-1',
#   'https://soundcloud.com/badbunny15/sets/x-100pre-2',
#   'https://soundcloud.com/soundcloud-the-peak/sets/midnight-dark-electro',
#   'https://soundcloud.com/soundcloud-the-peak/sets/atmospheric-edm',
#   'https://soundcloud.com/fresh-pressed/sets/fresh-pressed-tracks',
#   'https://soundcloud.com/user-861231864/sets/streaming-test-1/s-q4DAH',
#   'https://soundcloud.com/soundcloud-scenes/sets/psychedelic-indie',
#   'https://soundcloud.com/monstercat/sets/monstercat-instinct',
#   'https://soundcloud.com/monstercat/sets/dream-in-color-the-remixes',
#   'https://soundcloud.com/soundcloud-la-onda/sets/tropical-pop',
#   'https://soundcloud.com/soundcloud-la-onda/sets/rap-en-espanol',
#   'https://soundcloud.com/soundcloud-la-onda/sets/afro-latinx-diaspora',
#   'https://soundcloud.com/soundcloud-la-onda/sets/amor-norteno-love-ballads',
#   'https://soundcloud.com/soundcloud-circuits/sets/equalizers-female-electronic-producers',
#   'https://soundcloud.com/soundcloud-circuits/sets/zero-in-electronic-deep-focus',
#   'https://soundcloud.com/soundcloud-mainroom/sets/dance-new-hot',
#   'https://soundcloud.com/soundcloud-mainroom/sets/jack-chicago-house-icons',
#   'https://soundcloud.com/soundcloud-mainroom/sets/the-sounds-of-acid',
#   'https://soundcloud.com/soundcloud-mainroom/sets/a-history-of-detroit-techno',
#   'https://soundcloud.com/soundcloud-mainroom/sets/divas-women-of-house-music',
#   'https://soundcloud.com/soundcloud-shine/sets/chill-pop',
#   'https://soundcloud.com/soundcloud-scenes/sets/dreamo-emo-indie-rap',
#   'https://soundcloud.com/soundcloud-auras/sets/queen-things-women-of-r-b'
# ]

# admin = Admin.create!(name: "admin", email: Rails.application.credentials.admin_email, password: Rails.application.credentials.admin_password)
# puts 'Created sample admin'

# curators_data = []
# 10.times do
#   curators_data << { name: Faker::Ancient.god }
# end
# curators = Curator.create!(curators_data)
# puts 'Created curators'

# categories = [
#   { name: "history" },
#   { name: "catalytic" },
#   { name: "curated" }
# ]
# categories = Category.create!(categories)
# puts 'Created categories'

# albums_data = []
# 90.times do |order|
#   albums_data << {
#     title: Faker::Ancient.god,
#     soundcloud_url: soundcloud_urls.sample,
#     artist: Faker::Ancient.hero,
#     description: Faker::Lorem.paragraph,
#     bandcamp_url: Faker::Internet.url(host: 'bandcamp.com'),
#     curator_id: curators.sample.id,
#     category_id: categories.sample.id,
#   }
# end
# albums = Album.create!(albums_data)
# puts 'Created albums'

# Rake::Task['albums:init_current'].invoke


category_names = %w(history curated catalytic)
categories = category_names.map { |category| Category.find_or_create_by(name: category) }
puts "Created categories #{category_names.join(", ")}"

admin = Admin.create!(name: "admin", email: Rails.application.credentials.admin_email, password: Rails.application.credentials.admin_password)
puts 'Created sample admin'

categories.map { |category| category.import_albums("lib/#{category.name}.csv", 'replace') }
puts 'Added seed albums to categories'

# Daddy.import_daddies('lib/grandfathered_users.csv')
# puts "Added #{Daddy.count} grandfathered users"
