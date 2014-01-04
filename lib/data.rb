#!/usr/bin/env ruby
require 'json'

module Crawl
  class Data
    def initialize data, opts
      @data = data
      @options = opts
      array_into_string
      if @data['name'] == "" then @data['type'] = nil end
      @path = "data/#{data['site_name']}"
    end

    def array_into_string
      @data.each do |name, value|
        if value.kind_of?(Array) 
          @data[name] = value.join(',') 
        end
      end
    end

    def save
      if !@data['type'].nil?
        ap @data
        # save_to_api
        # save_to_file
      end
    end

    private

    def save_to_api
      # ap @data
      url = "#{@options[:host]}/api/v1/admin?access_token=#{@options[:api_key]}"
      res = Net::HTTP.post_form(URI.parse(url), @data)
    end

    def save_to_file
      FileUtils.mkdir_p @path
      FileUtils.mkdir_p @path + "/#{data['type']}" rescue nil
      File.open(@path + "/#{@data['type']}/#{@data['id']}.json","w").write(@data.to_json) rescue nil
    end

  end
end
