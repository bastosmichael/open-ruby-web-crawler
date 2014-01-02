#!/usr/bin/env ruby
require 'net/http'
require 'uri'
require 'ap'

module Crawl
  class Controller
    def initialize opts
      @options = opts
      set_host
      get_urls
      get_depth
      while url = @urls.pop do
        crawl = Crawl::Spider.new(url, @options)
        crawl.shotgun
        crawl = nil
      end
    end

    def set_host
      if @options[:host] == nil
        @options[:host] = 'http://0.0.0.0:3000'
      end
    end

    def get_urls
      @urls = []
      @urls.concat(get_urls_from_api.reverse)
      if @options[:urls]
        @urls.concat(@options[:urls])
      end
    end

    def get_urls_from_api
    	get_json("#{@options[:host]}/api/v1/get_urls?access_token=#{@options[:api_key]}")
    end

    def get_depth
      if @options[:depth] == nil then @options[:depth] = 3 end
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
          url = path
          uri = URI(url)
          response = Net::HTTP.get(uri)
          job = JSON.parse(response)
        rescue => e
          ap e
        end
    end
  end
end