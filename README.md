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

This app is deployed through heroku pipelines, merging a pr to staging will deploy app to [staging](https://stream.staging.catalyticsound.com) and is then promoted through the [heroku dashboard](https://dashboard.heroku.com/pipelines/47c86409-2fa5-4f29-b7c2-d94900e82206) to [production](https://stream.catalyticsound.com).
