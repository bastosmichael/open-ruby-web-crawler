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
      @type = meta_property "og:type" if !@type rescue nil
    end

    ###############################################################
    # og:title - The title of your object as it should appear 
    # within the graph, e.g., "The Rock".
    ###############################################################

    def og_name
      @name = meta_name "twitter:title" if !@name rescue nil
      @name = meta_property "og:title" if !@name rescue nil
    end

    ###############################################################
    # og:description - A one to two sentence description of your 
    # object.
    ###############################################################

    def og_description
      @description = meta_name "twitter:description" if !@description rescue nil
      @description = meta_property "og:description" if !@description rescue nil
    end

    ###############################################################
    # og:url - The canonical URL of your object that will be used 
    # as its permanent ID in the graph, e.g., 
    # "http://www.imdb.com/title/tt0117500/"
    ###############################################################

    def og_url
      @url = meta_name "twitter:url" if !@url rescue nil
      @url = meta_property "og:url" if !@url rescue nil
    end

    ###############################################################
    # og:image - An image URL which should represent your object 
    # within the graph.
    ###############################################################

    def og_image
      @image = meta_name "twitter:image" if !@image rescue nil
      @image = meta_property "og:image" if !@image rescue nil
    end

    ###############################################################
    # og:audio - A URL to an audio file to accompany this object.
    ###############################################################

    def og_audio
      @audio = meta_property "og:audio" if !@audio rescue nil
    end

    ###############################################################
    # og:determiner - The word that appears before this object's 
    # title in a sentence. An enum of (a, an, the, "", auto). If 
    # auto is chosen, the consumer of your data should chose 
    # between "a" or "an". Default is "" (blank).
    ###############################################################

    def og_determiner
      @determiner = meta_property "og:determiner" if !@determiner rescue nil
    end

    ###############################################################
    # og:locale - The locale these tags are marked up in. Of the 
    # format language_TERRITORY. Default is en_US.
    ###############################################################

    def og_locale
      @locale = meta_property "og:locale" if !@locale rescue nil
    end

    ###############################################################
    # og:locale:alternate - An array of other locales this page is 
    # available in.
    ###############################################################

    def og_locale_alternate
      @locale_alternate = meta_property "og:locale:alternate" if !@locale_alternate rescue nil
    end

    ###############################################################
    # og:site_name - If your object is part of a larger web site, 
    # the name which should be displayed for the overall site. 
    # e.g., "IMDb".
    ###############################################################

    def og_site_name
      @site_name = meta_property "og:site_name" if !@site_name rescue nil
    end

    ###############################################################
    # og:video - A URL to a video file that complements this object
    ###############################################################

    def og_video
      @video = meta_property "og:video" if !@video rescue nil
    end

    # ###############################################################
    # # 
    # ###############################################################

    # def og_
    #   @image = @page.doc.css('meta[@property="og:image"]').first['content'] if !@image rescue nil
    # end

    def meta_property metadata
        @page.doc.css("meta[@property='#{metadata}']").first['content']
    end

    def meta_name metadata
        @page.doc.css("meta[@name='#{metadata}']").first['content']
    end
  end
end