# app.rb
#grocery list

# use bundler
require 'rubygems'
require 'bundler/setup'
# load all of the gems in the gemfile
Bundler.require
require './models/TodoItem'
require './models/User'
require './models/Recipe'
require './models/Ingredient'

enable :sessions

if ENV['DATABASE_URL'] 
	ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])
else
	ActiveRecord::Base.establish_connection(
	:adapter => 'sqlite3',
	:database => 'db/development.db',
	:encoding =>'utf8'
	)
end

before do
	@user = User.find_by(name: session[:username])
end

get '/signup' do
	erb :signup
end

get '/logout' do
	session.clear
	erb :logout
end

post '/login' do
	user = User.find_by(name: params[:username])
	if user.nil?
		return erb :loginfailed
	end
	if user.authenticate(params[:password])
		session[:username] = user.name
		redirect '/todos'
	else 
		erb :loginfailed
	end
end

post '/new_item' do
	@user.todo_items.create(description: params[:task], due_date: params[:date], number: params[:number], unit: params[:unit])
	redirect '/todos'
end

post '/new_recipe' do
	@user.recipes.create(recipe_name: params[:name], instructions: params[:instructions])
	redirect '/recipes' #CHANGE TO INGREDIENTS
end

post '/new_ingredient' do
	@recipes = Recipes.find(params[:recipe_name])
	@recipes.ingredients.create(description: params[:description], number: params[:number], unit: params[:unit])
	redirect '/ingredients'
end

get '/update_number/:item' do
 	@todo_item = TodoItem.find(params[:item])
 	@todo_item.update(number: params[:number])
 	redirect '/edit'
end

get '/update_unit/:item' do
 	@todo_item = TodoItem.find(params[:item])
 	@todo_item.update(unit: params[:unit])
 	redirect '/edit'
end

post '/new_user' do 
 	@user = User.create(params)
 	redirect '/'
end


get '/delete_user/:user' do
	@user.destroy
	redirect '/'
end

get '/delete_item/:item' do
	@todo_item = TodoItem.find(params[:item])
	@user = @todo_item.user
	@todo_item.destroy
	redirect '/edit'
end

get '/' do
  erb :login
end

get '/todos' do
  redirect '/' unless @user
  @tasks = @user.todo_items.order(:description)
  erb :todo_list
end

get '/edit' do
	redirect '/' unless @user
	@tasks = @user.todo_items.order(:description)
	erb :edit_items
end

get '/recipes' do
  redirect '/' unless @user
  @recipes = @user.recipes.order(:recipe_name)
  erb :recipes
end

get '/ingredients' do
  redirect '/' unless @user
  @ingredient = Ingredient.find_by(params[:description])
  @ingredient = @recipe.ingredients.order(:description)
  erb :ingredients
end


get '/change_status_full/:item' do
	@todo_item = TodoItem.find(params[:item])
	@todo_item.update(due_date: "Full Supply")
	redirect '/edit'
end

get '/change_status_low/:item' do
	@todo_item = TodoItem.find(params[:item])
	@todo_item.update(due_date: "Running Low")
	redirect '/edit' 
end

get '/change_status_out/:item' do
	@todo_item = TodoItem.find(params[:item])
	@todo_item.update(due_date: "All Out!")
	redirect '/edit'
end




