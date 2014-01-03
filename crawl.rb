#!/usr/bin/env ruby
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/sites/*.rb'].each {|file| require file }

require 'trollop'

# PartyFoul.configure do |config|
#   # The collection of exceptions PartyFoul should not be allowed to handle
#   # The constants here *must* be represented as strings
#   config.blacklisted_exceptions = ['ActiveRecord::RecordNotFound', 'ActionController::RoutingError']

#   # The OAuth token for the account that is opening the issues on GitHub
#   config.oauth_token            = ENV['GITHUB_TOKEN']

#   # The API api_endpoint for GitHub. Unless you are hosting a private
#   # instance of Enterprise GitHub you do not need to include this
#   config.api_endpoint           = 'https://api.github.com'

#   # The Web URL for GitHub. Unless you are hosting a private
#   # instance of Enterprise GitHub you do not need to include this
#   config.web_url                = 'https://github.com'

#   # The organization or user that owns the target repository
#   config.owner                  = ENV['GITHUB_OWNER']

#   # The repository for this application
#   config.repo                   = ENV['GITHUB_REPO']

#   # The branch for your deployed code
#   # config.branch               = 'master'

#   # Additional labels to add to issues created
#   # config.additional_labels    = ['production']
#   # or
#   # config.additional_labels    = Proc.new do |exception, env|
#   #   []
#   # end

#   # Limit the number of comments per issue
#   # config.comment_limit        = 10

#   # Setting your title prefix can help with 
#   # distinguising the issue between environments
#   config.title_prefix         = Rails.env
# end

opts = Trollop::options do
  banner = ":Usage =>ruby crawl.rb -u http://amazon.com [options]" 
  opt :host,	"Set the host api to grab from", :type => :string
  opt :urls, 	"Set the URL you want to crawl", :type => :strings
  opt :api_key,	"Set the api key to grab from", :type => :string
  opt :depth,   "Set the depth you want to crawl", :type => :integer
  opt :file, 	"Set the URL to be grabbed from a url.txt file in data folder", :default => false
  opt :ua, 		"Set a custom user agent. Ex:-ua Googlebot"
end

trap("INT") { exit }
Crawl::Controller.new(opts)