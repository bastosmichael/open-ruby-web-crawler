#!/usr/bin/env ruby

    ###############################################################
    # The schemas are a set of 'types', each associated with a set 
    # of properties. The types are arranged in a hierarchy. 
    ###############################################################

module Crawl
  class SchemaOrg < Crawler
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
    # The name of the item.
    ###############################################################

    def schema_name
      # @name = @page.doc.css('//div[contains(@itemprop, "name")]').text rescue nil
    end

    ###############################################################
    # A short description of the item.
    ###############################################################

    def schema_description
      # @description = @page.doc.css('')
    end

    ###############################################################
    # URL of the item.
    ###############################################################

    def schema_url
      # @url = @page.doc.css('')
    end

    ###############################################################
    # URL of an image of the item.
    ###############################################################

    def schema_image
      # @image = @page.doc.css('')
    end

    ###############################################################
    # 
    ###############################################################

    # def schema_
      # # @ = @page.doc.css('')
    # end
  end
end