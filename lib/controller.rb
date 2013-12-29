#!/usr/bin/env ruby
require 'ap'

module Crawl
  class Controller
    def initialize opts
      @options = opts
      get_host
      get_urls
      get_depth
      while url = @urls.pop do
        crawl = Crawl::Spider.new(url, @depth)
        crawl.shotgun
        crawl = nil
      end
    end

    def get_host
      if @options[:host]
        @host = @options[:host]
      else
        @host = 'http://0.0.0.0:3000'
      end
    end

    def get_urls
      @urls = nil
      if @options[:urls] == nil 
        @urls = self.get_urls_from_api
      else 
        @urls = @options[:urls] 
      end
    end

    def get_urls_from_api
    	get_json("#{@host}/api/v1/get_urls")
    end

    def get_depth
      if @options[:depth] == nil then @depth = 3
      else @depth = @options[:depth] end
    end

    def get_file
      # if @options[:file] == true
      #   # ap File.open('url.txt', "rb").read
      #   # File.foreach('url.txt').map { |line| @urls << l.to_s }
      # end
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