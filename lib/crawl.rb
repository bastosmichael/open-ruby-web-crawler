require 'digest/md5'
require 'anemone'
require 'ap'
require 'csv'
require 'net/http'
require 'uri'
require 'json'

class Crawl
  def initialize
  	@connect = Controller.new
  	@urls = @connect.get_follow_urls
  	while url = @urls.pop
  		name = url.to_s.match(/www\.(.+)\./)[1].capitalize rescue nil
  		spider name, url
  	end
  end

  def spider name, url
  	ap name
  	Anemone.crawl(url, :discard_page_bodies => true, 
                        :obey_robots_txt => false, 
                        :user_agent => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_4) AppleWebKit/536.11 (KHTML, like Gecko) Chrome/20.0.1132.43 Safari/536.11", 
                        :large_scale_crawl => true) do |anemone|
      anemone.on_every_page do |page| 
      	puts page.url
      	begin
      	scrape = Amazon.new page
      	rescue
      	scrape = Scrape.new page
      	end
      	parse = Parse.new scrape
      end
    end
  end
end

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

class Scrape
  def initialize page
    @page = page
    @url = page.url.to_s
    @sku = nil
  end

  def find_sku
    return @sku
  end

  def find_url
    return @url
  end
end

class Amazon < Scrape
  def find_sku
    @sku = @page.body.match(/ASIN:<\/b> (.+?)<\/li>/)[1] rescue nil
    @sku = @page.url.to_s.match(/\/gp\/product\/(.+?)\//)[1] rescue nil if !@sku
    @sku = @page.url.to_s.match(/\/gp\/product\/(.+?)\?pf/)[1] rescue nil if !@sku
    @sku = @page.url.to_s.match(/\/dp\/(.+?)\/ref=/)[1] rescue nil if !@sku 
    @sku = @page.url.to_s.match(/\/dp\/(.+?)\//)[1] rescue nil if !@sku 
    @sku = self.test_sku
    return @sku
  end

  def find_review
    @sku = page.url.to_s.match(/\/product-reviews\/(.+?)\//)[1] rescue nil
    @sku = self.test_sku
    return @sku
  end

  def test_sku
    if @sku.length < 10 then sku = nil end if sku
    if @sku.length > 10 then sku = sku.to_s.match(/\/(.+)/)[1] rescue nil end if sku
    return @sku
  end

  def find_url
    if m = @url.match(/(.+?)\?/) then @url = m[1] end
    if m = @url.match(/(.+?)ref=/) then @url = m[1] end
    if m = @url.match(/(.+?)gcrnsts/) then @url = m[1] rescue @url end
    if !@url.match(@sku) then @url = @page.url end rescue nil
    return @url
  end
end

class Controller
  def initialize
	@host = "http://0.0.0.0:3000"
  end

  def get_follow_urls
  	get_json("#{@host}/api/get_follow_urls.json")
  end

  private

  def get_json path
      begin
        response = Net::HTTP.get(URI(path))
        job = JSON.parse(response)
      rescue => e
        ap e
      end
   end

end