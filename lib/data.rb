#!/usr/bin/env ruby
require 'json'

module Crawl
  class Data
    def initialize data
    	@data = data
    	@organization = @data['site_name']
      @id = @data['id']
      @type = @data['open_graph']['type'] if !@type rescue nil
      @type = @data['schema_org']['type'] if !@type rescue nil 
      self.check_directory
      ap @data
      @id = @data['name'].tr("/", "-").tr(" ", "_") if @type
    end

    def check_directory
      path = "data/#{@organization}"
      FileUtils.mkdir_p path
      FileUtils.mkdir_p path + "/Miscellaneous"
      FileUtils.mkdir_p path + "/#{@type}" rescue nil
    end

    def save_to_file path
      File.open(path,"a+").puts(@data.to_json)
    end

    def save
      if !@type.nil?
        save_to_file "data/#{@organization}/#{@type}/#{@id}.json"
      else
        save_to_file "data/#{@organization}/Miscellaneous/#{@id}.json"
      end
    end
  end
end