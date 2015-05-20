require 'data_mapper'
class User
	include DataMapper::Resource
	property :username, String, :key => true
	property :password, String

	self.raise_on_save_failure = true


	def self.for(session)
		unless user = session[:username] && get(session[:username].to_s)
			user = create
			session[:username] = user.username
		end
	end
	
end