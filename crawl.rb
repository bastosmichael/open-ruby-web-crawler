#!/usr/bin/env ruby
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/sites/*.rb'].each {|file| require file }

require 'trollop'

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