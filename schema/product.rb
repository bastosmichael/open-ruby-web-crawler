# require 'active_model'
# require 'thing.rb'

# module Schema
#     class Product < Thing
#       include ActiveModel::Validations
#       include ActiveModel::SerializerSupport

#       # TODO NAME THESE LIKE A RUBYIST
#        attr_accessor :aggregateRating,
#                      :audience,
#                      :brand,
#                      :color,
#                      :depth,
#                      :gtin13,
#                      :gtin14,
#                      :gtin8,
#                      :height,
#                      :isAccessoryOrSparePartFor,
#                      :isConsumableFor,
#                      :isRelatedTo,
#                      :isSimilarTo,
#                      :itemCondition,
#                      :logo,
#                      :manufacturer,
#                      :model,
#                      :mpn,
#                      :offers,
#                      :productID,
#                      :releaseDate,
#                      :review,
#                      :reviews,
#                      :sku,
#                      :weight,
#                      :width


#       attr_reader           :sku,
#                             :mpn,
#                             :offers

#       validates_presence_of :sku, 
#                             :offers
#     end
# end