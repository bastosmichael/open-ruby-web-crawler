#!/usr/bin/env ruby
require 'anemone'

module Crawl
  class Spider
    def initialize site, opts
      @options = opts
      @ua   = "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.63 Safari/537.36"
      @opts = self.settings
      @site = site
      @name = self.name
    end

    def shotgun
      Anemone.crawl(@site, @opts) do |anemone|
        #anemone.storage = Anemone::Storage.MongoDB
        anemone.on_every_page do |page|
          self.scrape page
          page.discard_doc!
          if @depth == 0 then return end
        end
      end
    end

    def scrape page
      begin
        data = Crawl.const_get(@name).new(page).save
      rescue
        data = Crawl::Scrape.new(page).save
      end 

      data['site_name'] = @name #if !data['site_name']

      begin
        saving = Crawl.const_get(@name+"Data").new(data, @options).save
      rescue
        saving = Crawl::Data.new(data, @options).save
      end 

      data = nil
      saving = nil
    end

    def name
      @site.to_s.match(/www.(.+)\.com/)[1].capitalize rescue @site.to_s.match(/\/\/(.+)\.com/)[1].capitalize
    end

    def settings
      {discard_page_bodies: true, 
       skip_query_strings: true, 
       # threads: 1, 
       depth_limit: @options[:depth], 
       read_timeout: 10, 
       user_agent: @ua,
       obey_robots_txt: false,
       large_scale_crawl: true}
    end
  end
end
