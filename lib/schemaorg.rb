#!/usr/bin/env ruby

    ###############################################################
    # The schemas are a set of 'types', each associated with a set 
    # of properties. The types are arranged in a hierarchy. 
    ###############################################################

module Crawl
  class SchemaOrg #< Parse
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
      # schema = @page.doc.css('//*[contains(@itemtype, "schema.org")]').first["itemtype"]
      @schema_org = false
      self.methods.grep(/schema/).each do |schema|
        self.send(schema) rescue nil
      end
      @schema_org = true if @type
    end

    ###############################################################
    # Types that have multiple parents are expanded out only once 
    # and have an asterisk 
    ###############################################################

    def schema_type
      @type = @page.body.match(/itemtype="http:\/\/schema.org\/(.+?)"/)[1]
    end

    ###############################################################
    # Grab Meta Data for Schema and assign instance variable
    ###############################################################

    def schema_meta
      @page.doc.css('//meta').each do |m|
        if !m[:itemprop].nil?
          instance_variable_set("@#{m[:itemprop].tr(" ", "_")}","#{m[:content]}")
        end
      end
    end

    ###############################################################
    # Grab Span Data for Schema and assign instance variable
    ###############################################################

    def schema_span
      @page.doc.css('//span').each do |m|
        if !m[:itemprop].nil?
          instance_variable_set("@#{m[:itemprop].tr(" ", "_")}","#{m.text}")
        end
      end
    end

    ###############################################################
    # Grabbing Keywords as Tags
    ###############################################################

    def schema_tags
      tags = @page.doc.css("meta[@name='keywords']").first['content'].split(/ |,/)
      tags.delete_if {|x| x.match(/and|for|more/)}
      @tags = tags.reject(&:empty?).uniq
    end

  end
end