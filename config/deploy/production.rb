role :app, %w{ubuntu@ec2-3-86-105-145.compute-1.amazonaws.com}
role :web, %w{ubuntu@ec2-3-86-105-145.compute-1.amazonaws.com}
role :db,  %w{ubuntu@ec2-3-86-105-145.compute-1.amazonaws.com}

set :ssh_options, {
  keys: %w(~/.ssh/aws.pem),
  forward_agent: false,
  auth_methods: %w(publickey password)
}
