# require 'digest/md5'
# require 'nokogiri'
# require 'mechanize'
# require 'thread'
# require 'awesome_print'
# require "addressable/uri"

# class Amazon < Crawl
# end

# class Crawl
# 	def initialize url
# 		uri = Addressable::URI.parse(url)
# 		self.spider uri
# 	end

# 	def spider url
# 		page = Scrape.new(url)
# 		puts page
# 		# parse = Parse.new(page.doc)
# 		# ap parse.links
# 	end
# end

# class Parse
# 	def initialize page
# 		@doc = page
# 	end

# 	def links
# 		@doc.css('a').map do |link| 
# 			link['href']
# 		end
# 	end
# end

# class Scrape
# 	def initialize url
# 		agent = self.create_agent
# 		@page = agent.get url
# 	end

# 	def doc
# 		@page.search('*')
# 	end

# 	def create_agent
# 	    agent = Mechanize.new
# 	    agent.user_agent = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_4) AppleWebKit/536.11 (KHTML, like Gecko) Chrome/20.0.1132.43 Safari/536.11'
# 	    agent.open_timeout = 300
# 	    agent.read_timeout = 300
# 	    agent.html_parser = Nokogiri::HTML
# 	    agent.ssl_version = 'SSLv3'
# 	    agent.keep_alive = false
# 	    agent.idle_timeout = 300
# 	    return agent
#   	end	
# end

# class Mechanize::Page
#   def resolve_url(url)
#     if url.nil?
#       url = []
#     end
#     mech.agent.resolve(url, self).to_s
#   end

#   def_delegator :parser, :extract, :extract
#   def_delegator :parser, :extract_all, :extract_all

#   def match(regex, options={}, &block)
#     text = root.to_s.encode('UTF-8')
#     if result = text.match(regex)
#       item = result[1]
#     end
#     filtered = yield(item,result) if block_given?
#     filtered || item
#   end

# end

# class Nokogiri::XML::Node
  
#   def extract(*selectors, &block)
#     options = selectors.last.is_a?(Hash) ? selectors.pop : {}
#     if result = search(*selectors).first
#       process(result,options,&block)
#     end
#   end

#   def extract_all(selector, options={}, &block)
#     if results = search(selector)
#       results.map do |result|
#         process(result, options, &block)
#       end
#     end
#   end

#   def process(item, options)
#     text = options[:attr] ? item[options[:attr]] : item.text
#     if text
#       text.encode!('UTF-8')
#       text = text.match(options[:regexp]) {|m| text = m[1]} if options[:regexp]
#       filtered = yield(text, item) if block_given?
#       (filtered || text).blank? ? nil : filtered || text
#     end
#   end
# end

# Amazon.new('http://2013.sf.wordcamp.org/')