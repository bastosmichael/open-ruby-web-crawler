#!/usr/bin/env ruby

module Crawl
  class Scrape
    def initialize page
      @page = page
      @url = page.url.to_s
      @sku = nil
    end

    def find_sku
      return @sku
    end

    def find_url
      return @url
    end
  end
end