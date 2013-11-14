#!/usr/bin/env ruby
require 'digest/md5'

module Crawl
  class Scrape < Crawler
    def build
      open_graph = Crawl::OpenGraph.new(@page).save #rescue nil
      open_graph.each { |k,v| instance_variable_set("@#{k}",v) }
      self.custom
    end

    def custom
    end
  end
end