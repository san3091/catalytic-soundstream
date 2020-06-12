set :branch, 'staging'

server '138.197.75.192', user: 'deploy', roles: %w{app db web}

set :linked_files, %w{config/credentials/staging.key}
set :conditionally_migrate, true
