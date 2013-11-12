#!/usr/bin/env ruby
$:.unshift File.dirname(__FILE__)
$:.unshift File.expand_path('../lib', __FILE__)
require 'trollop'
require 'controller.rb'

opts = Trollop::options do
  banner = ":Usage =>ruby run.rb -u http://amazon.com [options]" 
  opt :urls, 	"Set the URL you want to crawl", :type => :strings
  opt :spider, 	"Set whether or not you want to spider url", :default => true
  opt :ua, 		"Set a custom user agent. Ex:-ua Googlebot"
end

Crawl::Controller.new(opts)