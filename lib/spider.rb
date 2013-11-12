#!/usr/bin/env ruby

module Crawl
  class Spider
    def initialize site
      @site = site
      @name = self.name
      self.pages
    end

    def pages
      require 'anemone'
      Anemone.crawl(@site, 
                    :discard_page_bodies => true, 
                    :obey_robots_txt => false, 
                    :user_agent => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_4) AppleWebKit/536.11 (KHTML, like Gecko) Chrome/20.0.1132.43 Safari/536.11", 
                    :large_scale_crawl => true) do |anemone|
        anemone.on_every_page do |page|
          puts page.url
          page.discard_doc!
        end
      end
    end

    def name
      @site.to_s.match(/www.(.+)\./)[1].capitalize rescue nil
    end
  end
end