#!/usr/bin/env ruby
require 'digest/md5'

module Crawl
  class Scrape
    def initialize page
      @id = Digest::MD5.hexdigest(page.url.to_s)
      @page = page
      @data = {'id' => @id,
               'url' => page.url.to_s,
               'crawled_on' => Time.now.getutc}
      self.find_schema
      self.run
      self.terminate
    end

    def find_schema
      schema = @page.doc.css('meta[@property="og:type"]').first['content'].capitalize
      ap schema
    end

    def run

    end

    def terminate
      ap @data
      return @data
    end
  end
end