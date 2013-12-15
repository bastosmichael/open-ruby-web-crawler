#!/usr/bin/env ruby
require 'digest/md5'

module Crawl
  class Scrape #< Parse
    def initialize page
      @page = page
      @id = Digest::MD5.hexdigest(@page.url.to_s) if !@id
      @url = @page.doc.css("link[@rel='canonical']").first['href'] if !@url rescue nil
        @url = @page.url.to_s if !@url
        @name = @page.doc.at('title').inner_html if !@name rescue nil
        @description = @page.doc.css("meta[@name='description']").first['content'] if !@description rescue nil
        @mobile_url = @page.doc.css("link[@media='handheld']").first['href'] if !@mobile_url rescue nil
      self.build
    end
    
    def save
        remove_instance_variable(:@page)
        hash = {}
        instance_variables.each do |var| 
          hash[var.to_s.delete("@")] = instance_variable_get(var) 
        end
        hash
    end
    
    def build
      self.methods.grep(/scrape/).each do |s|
        self.send(s) 
      end
    end

    def scrape_open_graph
      og = Crawl::OpenGraph.new(@page)
      @open_graph = og.save #rescue nil
      @open_graph.each { |k,v| instance_variable_set("@#{k}",v) }
      og = nil
    end

    def scrape_schema_org
      schema = Crawl::SchemaOrg.new(@page)
      @schema_org = schema.save
      @schema_org.each { |k,v| instance_variable_set("@#{k}",v) }
      schema = nil
    end

    def scrape_custom
      self.methods.grep(/find/).each do |a|
            self.send(a) rescue nil
      end
    end
  end
end