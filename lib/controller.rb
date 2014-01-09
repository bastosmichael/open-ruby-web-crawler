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
        crawl.anemone_crawl
        # crawl.mechanize_crawl
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
      # @urls.concat(get_follow_urls)
      @urls.concat(get_all_urls)
      if @options[:urls]
        @urls.concat(@options[:urls])
      end
      ap @urls
    end

    def get_follow_urls
    	get_json("#{@options[:host]}/api/v1/get_follow_urls?access_token=#{@options[:api_key]}")
    end

    def get_all_urls
      get_json("#{@options[:host]}/api/v1/get_all_urls?access_token=#{@options[:api_key]}")
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
      ap path
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
