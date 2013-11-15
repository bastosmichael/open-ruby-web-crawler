#!/usr/bin/env ruby
require 'digest/md5'

module Crawl
  class Scrape
    def initialize page
      @page = page
      @crawled_on = Time.now.getutc
      @id = Digest::MD5.hexdigest(@page.url.to_s)
        @url = @page.url.to_s
        @name = @page.doc.at('title').inner_html rescue nil
      self.build
    end
    
    def save
        remove_instance_variable(:@page)
        hash = {}
        instance_variables.each do |var| 
          hash[var.to_s.delete("@")] = instance_variable_get(var) 
        end
        hash
    end

    def build
      self.methods.grep(/scrape/).each do |scrape|
        puts scrape
        self.send(scrape) 
      end
    end

    def scrape_open_graph
      og = Crawl::OpenGraph.new(@page)
      @open_graph = og.save #rescue nil
      # @open_graph.each { |k,v| instance_variable_set("@#{k}",v) }
    end

    def scrape_schema_org
      schema = Crawl::SchemaOrg.new(@page)
      @schema_org = schema.save
      # @schema_org.each { |k,v| instance_variable_set("@#{k}",v) }
    end

    def scrape_custom
    end
  end
end