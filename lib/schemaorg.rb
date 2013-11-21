#!/usr/bin/env ruby

    ###############################################################
    # The schemas are a set of 'types', each associated with a set 
    # of properties. The types are arranged in a hierarchy. 
    ###############################################################

module Crawl
  class SchemaOrg #< Parse
        def initialize page
            @page = page
            @id = Digest::MD5.hexdigest(@page.url.to_s)
            @url = @page.url.to_s
            @name = @page.doc.at('title').inner_html rescue nil
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
        self.send(schema)
      end
      @schema_org = true if @type
    end

    ###############################################################
    # Types that have multiple parents are expanded out only once 
    # and have an asterisk 
    ###############################################################

    def schema_type
      @type = @page.body.match(/itemtype="http:\/\/schema.org\/(.+?)"/)[1] rescue nil
    end

    ###############################################################
    # Grab Meta Data for Schema and assign instance variable
    ###############################################################

    def schema_meta
      @page.doc.css('//meta').each do |m|
        if !m[:itemprop].nil?
          instance_variable_set("@#{m[:itemprop]}","#{m[:content]}")
        end
      end
    end
  end
end