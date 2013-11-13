#!/usr/bin/env ruby
$:.unshift File.dirname(__FILE__)
$:.unshift File.expand_path('../lib', __FILE__)
require 'trollop'
require 'controller.rb'

opts = Trollop::options do
  banner = ":Usage =>ruby crawl.rb -u http://amazon.com [options]" 
  opt :urls, 	"Set the URL you want to crawl", :type => :strings
  opt :sniper, 	"Set whether the crawler only grabs one link", :default => false
  opt :ua, 		"Set a custom user agent. Ex:-ua Googlebot"
end

Crawl::Controller.new(opts)