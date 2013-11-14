#!/usr/bin/env ruby

module Crawl
  class OpenGraph < Crawler
    def build
      self.methods.grep(/og/).each do |og|
        self.send(og) 
      end
    end

    ###############################################################
    # og:type - The type of your object, e.g., "video.movie". 
    # Depending on the type you specify, other properties may also 
    # be required.
    ###############################################################

    def og_type
    	@type = @page.doc.css('meta[@property="og:type"]').first['content'] if !@type rescue nil
    end

    ###############################################################
    # og:title - The title of your object as it should appear 
    # within the graph, e.g., "The Rock".
    ###############################################################

    def og_name
    	@name = @page.doc.css('meta[@name="twitter:title"]').first['content'] if !@name rescue nil
      @name = @page.doc.css('meta[@property="og:title"]').first['content'] if !@name rescue nil
    end

    ###############################################################
    # og:description - A one to two sentence description of your 
    # object.
    ###############################################################

    def og_description
    	@description = @page.doc.css('meta[@name="twitter:description"]').first['content'] if !@description rescue nil
      @description = @page.doc.css('meta[@property="og:description"]').first['content'] if !@description rescue nil
    end

    ###############################################################
    # og:url - The canonical URL of your object that will be used 
    # as its permanent ID in the graph, e.g., 
    # "http://www.imdb.com/title/tt0117500/"
    ###############################################################

    def og_url
    	@url = @page.doc.css('meta[@name="twitter:url"]').first['content'] if !@url rescue nil
      @url = @page.doc.css('meta[@property="og:url"]').first['content'] if !@url rescue nil
    end

    ###############################################################
    # og:image - An image URL which should represent your object 
    # within the graph.
    ###############################################################

    def og_image
    	@image = @page.doc.css('meta[@name="twitter:image"]').first['content'] if !@image rescue nil
      @image = @page.doc.css('meta[@property="og:image"]').first['content'] if !@image rescue nil
    end

    ###############################################################
    # og:audio - A URL to an audio file to accompany this object.
    ###############################################################

    def og_audio
      @audio = @page.doc.css('meta[@property="og:audio"]').first['content'] if !@audio rescue nil
    end

    # ###############################################################
    # # 
    # ###############################################################

    # def og_
    #   @image = @page.doc.css('meta[@property="og:image"]').first['content'] if !@image
    # end
  end
end