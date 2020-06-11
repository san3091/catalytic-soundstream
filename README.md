# Catalytic Streaming Service

How to set this up:

* `bundle`
* `yarn install`
* `cp .env.template .env` and replace with real values
  * Santiago will provide you the keys to the jazzy kingdom as needed
* `rake db:seed`
  * in development it will create dummy data. If you want prod data run db:seed with RAILS_ENV=production
* `rake albums:init_current` will initialize the first 30 curated albums to be current

### Deployment

We use capistrano for deployment, so it's v easy.

`cap production deploy BRANCH=<staging/master>`

We do ont have a separate cap stage for staging, we use the prod settings for now.

Sometimes I need to check that stuff is set up right so we user capistrano remote

`cap production remote:console` for example
