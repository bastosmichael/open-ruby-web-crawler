#!/usr/bin/env ruby
require 'anemone'

module Crawl
  class Spider
    def initialize site
      @ua   = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_4) AppleWebKit/536.11 (KHTML, like Gecko) Chrome/20.0.1132.43 Safari/536.11"
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
        end
      end
    end

    def sniper
      Anemone.crawl(@site, @opts) do |anemone|
        #anemone.storage = Anemone::Storage.MongoDB
        anemone.on_every_page do |page|
          self.scrape page
          page.discard_doc!
          return
        end
      end
    end

    def scrape page
      begin
        puts "Using #{@name} class"
        data = Crawl.const_get(@name).new(page).save
      rescue
        data = Crawl::Scrape.new(page).save
      end 

      data['site_name'] = @name #if !data['site_name']
      saving = Crawl::Data.new(data).save
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
       depth_limit: 3, 
       read_timeout: 10, 
       user_agent: @ua,
       obey_robots_txt: false,
       large_scale_crawl: true}
    end
  end
end
