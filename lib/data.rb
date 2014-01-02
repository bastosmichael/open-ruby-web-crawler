#!/usr/bin/env ruby
require 'json'

module Crawl
  class Data
    def initialize data, opts
      # ap data
      @data = data
      @options = opts
      array_into_string
      if @data['name'] == "" then @data['type'] = nil end
      @path = "data/#{data['site_name']}"
      # @alternate_id = data['name'].tr("/", "-").tr(" ", "_") if @type
    end

    def array_into_string
      @data.each do |name, value|
        if value.kind_of?(Array) 
          @data[name] = value.join(',') 
        end
      end
    end

    def file_handling path
      FileUtils.mkdir_p @path
      FileUtils.mkdir_p @path + "/#{data['type']}" rescue nil
      File.open(path,"w").write(@data.to_json) rescue nil
    end

    def recursive_crawl
      File.open("data/urls.txt","a+").write(@data['url']+" ") rescue nil
    end

    def save
      if !@data['type'].nil?
        file_handling(@path + "/#{@data['type']}/#{@data['id']}.json")
        post_data
        # self.recursive_crawl
        # File.open(@path + "/#{@type}/.#{@alternate_id}.json","w").puts(@hash.to_json) 
      else
        #file_handling(@path + "/Miscellaneous/#{@data['id']}.json")
      end
    end

    private

    def post_data
      url = "#{@options[:host]}/api/v1/listings?access_token=#{@options[:api_key]}"
      # ap @data
      res = Net::HTTP.post_form(URI.parse(url), @data)
    end
  end
end
