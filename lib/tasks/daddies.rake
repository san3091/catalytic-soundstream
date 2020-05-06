require 'patreon'
require 'csv'

namespace :daddies do
  desc 'populated daddies tale with grandfathered users from patreon'
  task :import, [:members_file] => [:environment] do |t, args|
    daddies = []
    CSV.foreach(args.members_file, headers: true) do |row|
      puts "importing #{row[0]}"
      daddies << Daddy.new(name: row[0], email: row[1]) if is_member(row[8])
    end

    Daddy.import(daddies)
  end
end

def is_member(tier)
  tier && tier == "Member"
end
