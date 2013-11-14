#!/usr/bin/env ruby
require 'anemone'

module Crawl
  class Spider
    def initialize site
      @ua   = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_4) AppleWebKit/536.11 (KHTML, like Gecko) Chrome/20.0.1132.43 Safari/536.11"
      @opts = self.settings
      @site = site
      @name = self.name
      ap @name
    end

    def shotgun
      Anemone.crawl(@site, @opts) do |anemone|
        # anemone.storage = Anemone::Storage.Redis
        anemone.on_every_page do |page|
          self.scrape page
          page.discard_doc!
        end
      end
    end

    def sniper
      Anemone.crawl(@site, @opts) do |anemone|
        # anemone.storage = Anemone::Storage.Redis
        anemone.on_every_page do |page|
          self.scrape page
          page.discard_doc!
          return
        end
      end
    end

    def scrape page
      Crawl::Scrape.new(page)
    end

    def name
      @site.to_s.match(/www.(.+)\./)[1].capitalize rescue @site.to_s.match(/\/\/(.+)\./)[1].capitalize
    end

    def settings
      {discard_page_bodies: true, 
       skip_query_strings: true, 
       # depth_limit:2000, 
       read_timeout: 10, 
       user_agent: @ua,
       obey_robots_txt: false,
       large_scale_crawl: true}
    end
  end
end