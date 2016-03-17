class EndorsementsController < ApplicationController
  def index
    @endorsements = {
      recent: EndorsementTweet.order('tweeted_at desc').first(1000),
      most_followers: EndorsementTweet.order('followers desc').first(1000)
    }
  end
end
