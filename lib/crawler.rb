#!/usr/bin/env ruby

module Crawl
	class Crawler
		def initialize page
			@page = page
			@id = Digest::MD5.hexdigest(@page.url.to_s)
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