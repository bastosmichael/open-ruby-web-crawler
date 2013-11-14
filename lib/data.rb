#!/usr/bin/env ruby
require 'json'

module Crawl
  class Data
    def initialize data
    	@data = data
    	@organization = @data['organization']
      @id = @data['id']
      @type = @data['open_graph']['type'] rescue nil
      self.check_directory
      ap @data
    end

    def check_directory
      path = "data/#{@organization}"
      FileUtils.mkdir_p path
      FileUtils.mkdir_p path + "/misc"
      FileUtils.mkdir_p path + "/#{@type}" rescue nil
    end

    def save_to_file path
      File.open(path,"a+").puts(@data.to_json)
    end

    def save
      if !@type.nil?
        save_to_file "data/#{@organization}/#{@type}/#{@id}.json"
      else
        save_to_file "data/#{@organization}/misc/#{@id}.json"
      end
    end
  end
end