#!/usr/bin/env ruby
require 'digest/md5'

module Crawl
  class Scrape < Crawler
    def build
      self.methods.grep(/scrape/).each do |scrape|
        self.send(scrape) 
      end
    end

    def scrape_open_graph
      og = Crawl::OpenGraph.new(@page)
      @open_graph = og.save #rescue nil
      @open_graph.each { |k,v| instance_variable_set("@#{k}",v) }
    end

    def scrape_schema_org
      schema = Crawl::SchemaOrg.new(@page)
      @schema_org = schema.save
      @schema_org.each { |k,v| instance_variable_set("@#{k}",v) }
    end

    def scrape_custom
    end
  end
end