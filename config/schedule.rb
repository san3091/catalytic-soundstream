set :output, 'log/cron.log'
env :PATH, ENV['PATH']

every 1.hour do
  rake 'albums:daily_rotate'
end
