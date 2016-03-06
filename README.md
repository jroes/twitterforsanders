## Hacking

* Create a standard Twitter app
* Add TWITTER_CONSUMER_KEY and TWITTER_CONSUMER_SECRET to your .env
* `rake db:create`
* `forego run rake collector:twitter_endorsements` (tail log/development.log for progress)
