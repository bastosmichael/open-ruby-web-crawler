#!/usr/bin/env ruby
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each {|file| require file }
Dir[File.dirname(__FILE__) + '/lib/**/*.rb'].each {|file| require file }

require 'trollop'

opts = Trollop::options do
  banner = ":Usage =>ruby crawl.rb -u http://amazon.com [options]" 
  opt :urls, 	"Set the URL you want to crawl", :type => :strings
  opt :sniper, 	"Set whether the crawler only grabs one link", :default => false
  opt :ua, 		"Set a custom user agent. Ex:-ua Googlebot"
end

trap("INT") { exit }
Crawl::Controller.new(opts)