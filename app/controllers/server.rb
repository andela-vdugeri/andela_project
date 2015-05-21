require 'sinatra/base'

class Server < Sinatra::Base
	configure do
		enable :sessions
		set :session_secret, 'This is supposed to be be very long and very hard to decipher, usuaully.'
	end


	get '/' do
		@categories = Category.all
		users = User.all
		if users.any? 
			erb :login, :layout => :home_layout
		else
			erb :new_user
		end
	end

	post '/user/new' do
		username = params[:username]
		password = params[:password]
		User.create({:username => username, :password => password})

		erb :login, :layout => :home_layout
	end

	get '/home' do
		halt(401, 'not authorized') unless session[:admin]
		@products = Product.all
		@categories = Category.all
		erb :home
	end


	get '/products/new' do
		halt(401, 'not authorized') unless session[:admin]
		@product = Product.new
		@categories = Category.all
		erb :new_item, :layout => :new_layout
	end

	get '/products'  do
		halt(401, 'not authorized') unless session[:admin]
		@products = Product.all
		@categories = Category.all
		erb :products
	end

	get '/products/:id' do
		halt(401, 'not authorized') unless session[:admin]
		@product = Product.get(params[:id])
		@categories = Category.all
		erb :show_product
	end


	post '/products' do
		halt(401, 'not authorized') unless session[:admin]
		@product = Product.new
		@product.name = params[:name]
		@product.price = params[:price]
		@product.quantity = params[:quantity]
		@product.category_id = params[:category_id]
		filename = params['myfile'][:filename]
		extension = File.extname(params['myfile'][:filename])
		#puts extension
		filename.replace params[:name]+extension
		#puts Dir.getwd
		path = File.join(Dir.getwd+'/app/public/images/', params['myfile'][:filename])
		File.open(path, "wb") do |f|
     		f.write(params['myfile'][:tempfile].read)
  	 	end
    	puts "file uploaded"

		@product.save
		redirect to("/products/#{@product.id}")
	end


	post '/categories/create' do
		halt(401, 'not authorized') unless session[:admin]
		Category.create({:name => params[:category]})

		@categories = Category.all
		@products = Product.all
		erb :home
	end


	get '/categories/new' do
		halt(401, 'not authorized') unless session[:admin]
		@categories = Category.all
		erb :new_category
	end

	get '/categories/:id/products' do
		halt(401, 'not authorized') unless session[:admin]
		@categories = Category.all
		@products = Product.all(:category_id => params[:id])
		erb :show_products, :layout => :products_layout

	end

	# 	##  create a category
	# post '/categories' do
	# 	halt(401, 'not authorized') unless session[:admin]
	# 	@categories = Category.all
	# 	category = Category.new
	# 	category.name = params[:category]
	# 	category.save
	# 	redirect to("/categories")
	# end




	# get and display products in a list
	get '/sales' do
		halt(401, 'not authorized') unless session[:admin]
		@categories = Category.all
		products = Product.all
		erb :demo_cart, :layout => :demo_layout, :locals => {:products => products}
	end

	get '/cart/product/:id' do
		id = params[:id]
		product = Product.get(id)
		item = OrderItem.new
		item.item_name = product.name
		item.cost = product.price
		item.quantity = 1
		item.sale_transaction_id = rand(1000) + 1;
		item.save
		

		@categories = Category.all
		@products = Product.all
		sold = OrderItem.first(:item_name => item.item_name)
		erb :cart, :locals =>{:sold => sold}
	end
	## log user into a session
	post '/login' do
		@categories = Category.all
		username = params[:username]
		password = params[:password]

		@user = User.first(:username => username)

		if(@user == nil)
			@message = "Incorrect login credentials"
			erb :login, :layout => :home_layout

		elsif params[:password] == @user.password
			session[:admin] = true
			redirect to("/home")
		else
			@message = "Incorrect login credential"
			erb :login, :layout => :home_layout
		end
	end


	post '/cart' do
		@categories = Category.all

	end #


	get '/logout' do
		session[:admin] = false;
		redirect to('/')
	end



	not_found do
		"Boom"
	end

	# start the server if ruby file executed directly
	  run! if app_file == $0
end