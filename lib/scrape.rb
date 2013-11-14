#!/usr/bin/env ruby
require 'digest/md5'

module Crawl
  class Scrape < Crawler
    def build
      @crawled_on = Time.now.getutc
      @id = Digest::MD5.hexdigest(@page.url.to_s)
      @url = @page.url.to_s
      @title = @page.doc.at('title').inner_html rescue nil
      @open_graph = Crawl::OpenGraph.new(@page).save #rescue nil
      self.custom
    end

    def custom
    end
  end
end