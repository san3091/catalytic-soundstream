set :output, 'log/cron.log'
env :PATH, ENV['PATH']
env :GEM_PATH, ENV['GEM_PATH']

every 1.hour do
  rake 'albums:daily_rotate'
end
