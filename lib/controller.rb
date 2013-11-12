#!/usr/bin/env ruby
require 'spider.rb'
require 'ap'

module Crawl
  class Controller
    def initialize opts
      @host = "http://0.0.0.0:3000"
      if opts[:urls] == nil then @urls = self.get_follow_urls 
      else @urls = opts[:urls] end
      while url = @urls.pop do
        Crawl::Spider.new(url)
      end
    end

    def get_follow_urls
    	get_json("#{@host}/api/get_follow_urls.json")
    end

    private

    def get_json path
        begin
          response = Net::HTTP.get(URI(path))
          job = JSON.parse(response)
        rescue => e
          ap e
        end
    end
  end
end