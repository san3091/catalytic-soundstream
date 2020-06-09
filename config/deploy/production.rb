set :branch, ENV['BRANCH'] if ENV['BRANCH']

server '167.71.87.188', user: 'deploy', roles: %w{app db web}

set :linked_files, %w{config/credentials/production.key}
