require 'data_mapper'
class OrderItem < Sinatra::Base
	include DataMapper::Resource
	property :item_id, Serial, :key => true
	property :item_name, String
	property :cost, Float
	property :quantity, Integer

	belongs_to :order
	
end