#!/usr/bin/env ruby
require 'json'

module Crawl
  class Data
    def initialize data
    	@data = data
    	self.organization
      self.id
      self.check_directory
      ap @id
      ap @organization
      ap @data
    end

    def organization
    	@organization = @data['organization']
    end

    def id
    	@id = @data['id']
    end

    def type
      @type = @data['open_graph']['type']
    end

    def check_directory
      # FileUtils.mkdir_p "data/#{@organization}"
      # FileUtils.mkdir_p "data/#{@organization}/misc"
      FileUtils.mkdir_p "data/#{@organization}/#{@type}"
    end

    def save_to_file path
      File.open(path,"a+").puts(@data.to_json)
    end

    def save
      if !@data['open_graph']['type'].nil?
        save_to_file "data/#{@organization}/#{@type}/#{@id}.json"
      # else
      #   save_to_file "data/#{@organization}/misc/#{@id}.json"
      end
    end
  end
end