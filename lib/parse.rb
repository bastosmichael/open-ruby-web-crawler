#!/usr/bin/env ruby

module Crawl
	class Parse
	  def initialize scrape
	    sku = scrape.find_sku
	    if sku
		  	url = scrape.find_url
		   	ap sku
		   	ap url
	    end
	  end
	end
end