class EndorsementsController < ApplicationController
  def index
    @endorsements = {
      recent: EndorsementTweet.order('tweeted_at desc').first(10),
      most_followers: EndorsementTweet.order('followers desc').first(10)
    }
  end
end
