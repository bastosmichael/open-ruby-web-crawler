#!/usr/bin/env ruby
require 'digest/md5'

module Crawl
  class Scrape < Parse
    def build
      self.methods.grep(/scrape/).each do |s|
        self.send(s) 
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
      self.methods.grep(/find/).each do |a|
            self.send(a) rescue nil
      end
    end
  end
end