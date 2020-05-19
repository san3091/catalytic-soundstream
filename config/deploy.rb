# config valid for current version and patch releases of Capistrano
lock "~> 3.14.0"

set :application, "catalytic-soundstream"
set :repo_url, "git@example.com:san3091/catalytic-streaming-admin.git"

# Deploy to user's home dir
set :deploy_to, "/home/deploy/#{fetch :application}"

append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', '.bundle', 'public/system', 'public/uploads'

# Default value for keep_releases is 5
set :keep_releases, 5

