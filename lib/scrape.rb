#!/usr/bin/env ruby
require 'digest/md5'

module Crawl
  class Scrape < Crawler
    def build
      @id = Digest::MD5.hexdigest(@page.url.to_s)
      @title = @page.doc.at('title').inner_html rescue nil
      @url = @page.url.to_s
      @crawled_on = Time.now.getutc
      self.find_schema
      self.run
    end

    def find_schema
      @schema = Crawl::OpenGraph.new(@page).save #rescue nil
    end

    def run

    end

    def save
        remove_instance_variable(:@page)
        hash = {}
        instance_variables.each do |var| 
          hash[var.to_s.delete("@")] = instance_variable_get(var) 
        end
        hash
    end
  end
end