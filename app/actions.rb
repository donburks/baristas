# Homepage (Root path)
helpers do
	def handle_errors
		@errors = session[:error] if session[:error]
		session[:error] = nil
	end

#	def current_user
#		@current_user = User.find(session[:user_id]) if session[:user_id]
#	end
end

before do 
	#current_user
	handle_errors
end

get '/' do
  erb :index
end

get '/baristas/new' do
	erb :'baristas/new'
end

post '/baristas/create' do
	name = params[:name]
	barista = Barista.new name: name

	if barista.save
		redirect "/baristas/#{barista.id}"
	else
		session[:error] = "You suck. Try again."
		redirect '/baristas/new'
	end
end

get '/baristas/:id' do
	@barista = Barista.find(params[:id])
	erb :'baristas/show'
end

get '/coffees/new' do
	@baristas = Barista.all
	erb :'coffees/new'
end

post '/coffees/create' do
	name = params[:name]

	barista = Barista.find(params[:barista])
	coffee = barista.coffees.new name: name

	if coffee.save
		#redirect "/coffees"
		#redirect "/baristas/#{barista.id}/coffees"
		#redirect "/baristas/#{barista.id}/coffees/#{coffee.id}"
		redirect "/coffees/#{coffee.id}"
	else
		session[:error] = "No coffee for you."
		redirect "/coffees/new"
	end
end

get '/coffees/:id' do
	@coffee = Coffee.find(params[:id])		
	erb :'coffees/show'
end

get '/baristas/:barista_id/coffees/:id' do
	@coffee = Coffee.find(params[:id])		
	erb :'coffees/show'
end

get '/baristas' do
	@baristas = Barista.all
	erb :'baristas/index'
end
