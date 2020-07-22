set :output, 'log/cron.log'
env :PATH, ENV['PATH']

every 1.day, at: '6am' do
  rake 'albums:daily_rotate'
end
