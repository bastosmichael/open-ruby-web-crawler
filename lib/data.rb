#!/usr/bin/env ruby
require 'json'

module Crawl
  class Data
    def initialize data
      ap data
      @data = data
      @data['created_on'] = Date.today
      @data['edited_on'] = Date.today
      @hash = {}
    	@organization = data['site_name']
      @id = data['id']
      @type = data['type'] if !@type rescue nil
      @type = data['type'] if @type.nil?
      if data['name'] == "" then @type = nil end
      @path = "data/#{@organization}"
      # @alternate_id = data['name'].tr("/", "-").tr(" ", "_") if @type
    end

    def file_handling path
      FileUtils.mkdir_p @path
      FileUtils.mkdir_p @path + "/Miscellaneous"
      FileUtils.mkdir_p @path + "/#{@type}" rescue nil
      # @hash = JSON.parse(File.open(path, "rb").read) rescue {}
      #self.canonical_data 'id'
      #self.canonical_data 'name'
      #self.canonical_data 'description'
      #self.canonical_data 'url'
      #self.canonical_data 'image'
      #self.canonical_data 'site_name'
      #@hash["#{Date.today}"] = @data
      
      File.open(path,"w").write(@data.to_json) rescue nil
    end

    def canonical_data data
      @hash[data] = @data[data]
      @data.delete(data)
    end

    def recursive_crawl
      File.open("data/urls.txt","a+").write(@data['url']+" ") rescue nil
    end

    def save
      if !@type.nil?
        file_handling(@path + "/#{@type}/#{@id}.json")
        # self.recursive_crawl
        # File.open(@path + "/#{@type}/.#{@alternate_id}.json","w").puts(@hash.to_json) 
      else
        #file_handling(@path + "/Miscellaneous/#{@id}.json")
      end
    end
  end
end
