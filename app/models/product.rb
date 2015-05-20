require 'data_mapper'
class Product
	include DataMapper::Resource
	property :id, Serial
	property :name, String
	property :category_id, Integer
	property :price, Float
	property :quantity, Integer

	#belongs_to :category
end