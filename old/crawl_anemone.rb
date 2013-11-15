# #!/usr/bin/env ruby
# require 'digest/md5'
# require 'anemone'
# require 'ap'
# require 'csv'

# class Crawl
#   def initialize site
#     # name = site.to_s.match(/www\.(.+)\./)[1].capitalize
#     # @retailer = Corporation.find_or_create_by_url :url => site, :name => name
#     @product_count = 0
#     @review_count = 0
#     # ap @retailer
#     self.spider site
#   end

#   def spider site
#     Anemone.crawl(site, :discard_page_bodies => true, 
#                         :threads => 1, 
#                         :obey_robots_txt => false, 
#                         :user_agent => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_4) AppleWebKit/536.11 (KHTML, like Gecko) Chrome/20.0.1132.43 Safari/536.11", 
#                         :large_scale_crawl => true) do |anemone|
#       anemone.on_every_page do |page| 
#         scrape = Scrape.new(page)
#         sku = scrape.find_sku
#         if sku
#           @product_count = @product_count+1
#           url = scrape.find_url
#           listing = {}
#           # listing[:id] = @global_count
#           listing[:sku] = sku
#           listing[:name] = page.doc.css('h1 span').text rescue nil
#           listing[:listing_id] = Digest::MD5.hexdigest(url.to_s)
#           listing[:url] = url.to_s
#           listing[:mpn] = page.body.match(/<li><b>Item model number:<\/b> (.+?)<\/li>/)[1] rescue nil

#           seller = page.doc.css('.buying span a[1]').text rescue nil
#           seller = seller.gsub(/:/,'') rescue seller if seller
#           seller = seller.match(/(.+?)search/)[1] rescue seller if seller.match(/search results/)
#           seller = seller.match(/(.+?)Why/)[1] rescue seller if seller.match(/Why/)
#           seller = seller.match(/(.+?)Learn/)[1] rescue seller if seller.match(/Learn/)
#           seller = seller.match(/(.+?)Details/)[1] rescue seller if seller.match(/Details/)
#           seller = seller.match(/(.+?)How/)[1] rescue seller if seller.match(/How Account/)
#           seller = seller.match(/(.+?)these/)[1] rescue nil if seller.match(/these sellers/)
#           seller = seller.match(/(.+?)Terms/)[1] rescue seller if seller.match(/Terms and Conditions/)
#           sellers = seller if !seller.match(/stars/)  #if by_seller#.to_s.match(/by.+<span id.+><a href=".+">(.+)<\/a>/)[1] rescue nil

#           offer = {}
#           offer[:sku] = sku
#           offer[:price] = page.doc.css('.priceLarge').first.text rescue nil
#           offer[:availability] = page.doc.css('.availGreen').text rescue nil

#           categories = []
#           page.doc.css('//*[@id="SalesRank"]/ul/li/span/a').each do |t|
#             if categories.include? t.text
#             else
#               categories.push t.text
#             end
#           end
          
#           ap "Product: #{@product_count}"
#           File.open("listings.json", "a") { |f| f.puts "#{listing.to_json};" }
#           File.open("offers.json", "a") { |f| f.puts "#{offer.to_json};" }
#           File.open("sellers.yml", "a") { |f| f.puts "#{sellers};" if sellers}
#           File.open("categories.yml", "a") { |f| f.puts "#{categories};" if categories != [] }
#           # @amazon.listings.find_or_create_by_name(:name => name,
#           #                     :listing_id => Digest::MD5.hexdigest(url),
#           #                     :url => url,
#           #                     :mpn => mpn,
#           #                     :sku => sku)
#         else
#             if page.url.to_s.match(/\/(.+?)\//).length == 10
#               File.open("other_urls.csv", "a") { |f| f.puts "#{page.url};" }
#             end
#         end
#         # if review = find_review(page)
#         #   # test = page.doc.css('//*[@id="productReviews"]/tbody/tr/td[1]')
#         #   # ap test
#         #     @review_count = @review_count+1
#         #     reviews = {}
#         #     url = find_url review, page.url
#         #     reviews[:sku] = review
#         #     reviews[:url] = url.to_s
#         #     reviews[:review_id] = Digest::MD5.hexdigest(url.to_s)
#         #     ap "Review: #{@review_count}"
#         #     ap reviews
#         #     # ap r
#         #     File.open("reviews.json", "a") { |f| f.puts "#{reviews.to_json}" }
#         #   # end
#         # end
#         page.discard_doc!
#       end
#     end
#   end
# end

# class Scrape
#   def initialize page
#     @page = page
#     @url = page.url.to_s
#     @sku = nil
#   end

#   def find_sku
#     @sku = @page.body.match(/ASIN:<\/b> (.+?)<\/li>/)[1] rescue nil
#     @sku = @page.url.to_s.match(/\/gp\/product\/(.+?)\//)[1] rescue nil if !@sku
#     @sku = @page.url.to_s.match(/\/gp\/product\/(.+?)\?pf/)[1] rescue nil if !@sku
#     @sku = @page.url.to_s.match(/\/dp\/(.+?)\/ref=/)[1] rescue nil if !@sku 
#     @sku = self.test_sku
#     return @sku
#   end

#   def find_review
#     @sku = page.url.to_s.match(/\/product-reviews\/(.+?)\//)[1] rescue nil
#     @sku = self.test_sku
#     return @sku
#   end

#   def test_sku
#     if @sku.length < 10 then sku = nil end if sku
#     if @sku.length > 10 then sku = sku.to_s.match(/\/(.+)/)[1] rescue nil end if sku
#     return @sku
#   end

#   def find_url
#     if m = @url.match(/(.+?)\?/) then @url = m[1] end
#     if m = @url.match(/(.+?)ref=/) then @url = m[1] end
#     if m = @url.match(/(.+?)gcrnsts/) then @url = m[1] end
#     if !@url.match(@sku) then @url = @page.url end
#     return @url
#   end
# end

# Crawl.new('http://www.amazon.com/Desktops/b/ref=sa_menu_deskserv?ie=UTF8&node=4972214011')