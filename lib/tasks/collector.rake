namespace :collector do
  desc "Collect Twitter endorsements"
  task twitter_endorsements: :environment do
    TwitterEndorsementCollector.new.collect_until_empty
  end

end
