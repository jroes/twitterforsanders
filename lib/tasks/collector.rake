namespace :collector do
  desc "Collect Twitter endorsements"
  task twitter_endorsements: :environment do
    search_queries = YAML.load('config/twitter_search_queries.yml')
    TwitterEndorsementCollector.new.collect_for_queries(search_queries[:queries])
  end

end
