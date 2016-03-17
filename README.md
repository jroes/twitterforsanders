## twitterforsanders

This is basically a re-implementation of the pretty awesome idea that exists at https://github.com/mbiokyle29/endorse-bot.

It tracks folks who have said they endorse Bernie on Twitter and stores them for analysis.

The "production" app lives at:

https://twitterforsanders.herokuapp.com

## Hacking

* Create a standard Twitter app
* Add TWITTER_CONSUMER_KEY and TWITTER_CONSUMER_SECRET to your .env
* `bundle install`
* `rake db:create`
* `rake db:migrate`

* `rake collector:twitter_endorsements` (tail log/development.log for progress)
* `forego run rake collector:twitter_endorsements` (background)