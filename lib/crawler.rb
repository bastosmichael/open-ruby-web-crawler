#!/usr/bin/env ruby

module Crawl
	class Crawler
		def initialize page
			@page = page
			@crawled_on = Time.now.getutc
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
	end
end