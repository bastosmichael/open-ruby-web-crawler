#!/usr/bin/env ruby
require 'digest/md5'

module Crawl
  class Scrape
    def initialize page
      @id = Digest::MD5.hexdigest(page.url.to_s)
      @page = page
      title = page.doc.at('title').inner_html rescue nil
      @data = {:id => @id,
               :name => title,
               :url => page.url.to_s,
               :crawled_on => Time.now.getutc}
      self.find_schema
      # self.run
    end

    def find_schema
      @schema = @page.doc.css('meta[@property="og:type"]').first['content']
      thing = {}
      thing[:name] = @page.doc.css('meta[@name="twitter:title"]').first['content'] if !thing[:name]
      thing[:name] = @page.doc.css('meta[@property="og:title"]').first['content'] if !thing[:name]
      thing[:description] = @page.doc.css('meta[@name="twitter:description"]').first['content'] if !thing[:description]
      thing[:description] = @page.doc.css('meta[@property="og:description"]').first['content'] if !thing[:description]
      thing[:url] = @page.doc.css('meta[@name="twitter:url"]').first['content'] if !thing[:url]
      thing[:url] = @page.doc.css('meta[@property="og:url"]').first['content'] if !thing[:url]
      thing[:image] = @page.doc.css('meta[@name="twitter:image"]').first['content'] if !thing[:image]
      thing[:image] = @page.doc.css('meta[@property="og:image"]').first['content'] if !thing[:image]
      @data[@schema] = thing
    rescue
      @schema = nil
    end

    def run

    end

    def save
      @data #if @schema
    end
  end
end