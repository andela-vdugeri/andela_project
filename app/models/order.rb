
require 'data_mapper'
class Order
	include DataMapper::Resource
	property :transaction_id, Serial
	property :customer_name, String
	property :customer_address, Text
	property :customer_phone, String
	property :total , Float

	has n, :orderItems

end