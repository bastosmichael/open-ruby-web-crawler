# require 'active_model'
# require 'active_model/serializer'
# require 'active_model/validations'
# require 'active_model_serializers'
# require "addressable/uri"
# require "product.rb"

# module Schema
# 	class AbsoluteURI < ActiveModel::Validator
# 	  def validate(thing)
# 	    unless thing.url && thing.url.absolute?
# 	      thing.errors[:url] << "Not Absolute"
# 	    end

# 	    if thing.image && !thing.image.absolute?
# 	      thing.errors[:image] << "Not Absolute"
# 	    end
# 	  end
# 	end

# 	class Thing
# 	  include ActiveModel::Validations
# 	  include ActiveModel::SerializerSupport

# 	  attr_accessor :name,
# 	  				:description,
# 	  				:image,
# 	  				:url

# 	  validates_presence_of :url, 
# 	  						:name

# 	  validates_with AbsoluteURI

# 	  def url= url
# 	    begin
# 	      @Url = Addressable::URI.parse(url)
# 	    rescue
# 	      @Url = nil
# 	    end
# 	  end

# 	  def image= image
# 	    begin
# 	      @image = Addressable::URI.parse(image)
# 	    rescue
# 	      @image = nil
# 	    end
# 	  end
# 	end
# end