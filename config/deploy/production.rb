set :branch, 'master'

server '138.197.5.16', user: 'deploy', roles: %w{app db web}

set :linked_files, %w{config/credentials/production.key}
set :conditionally_migrate, true
