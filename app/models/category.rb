require 'data_mapper'
class Category
	include DataMapper::Resource
	property :id, Serial
	property :name, String

	#has n, :products
end