# app.rb
#grocery list

# use bundler
require 'rubygems'
require 'bundler/setup'
# load all of the gems in the gemfile
Bundler.require
require './models/TodoItem'
require './models/User'

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

 # get '/' do
	#  @tasks = TodoItem.all.order(:due_date)
	#  erb :index
 # end

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
	#require 'json'
	#JSON.pretty_generate params
end

 post '/new_item' do
 	@user.todo_items.create(description: params[:task], due_date: params[:date])
	 redirect '/todos'
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
	redirect '/todos'
end

get '/' do
  @users = User.all.order(:name)
  erb :login
end

get '/todos' do
  redirect '/' unless @user
  @tasks = @user.todo_items.order(:due_date)
  erb :todo_list
end

get '/change_status_full/:item' do
	@todo_item = TodoItem.find(params[:item])
	@todo_item.update(due_date: "Full Supply")
	redirect '/todos'
end

get '/change_status_low/:item' do
	@todo_item = TodoItem.find(params[:item])
	@todo_item.update(due_date: "Running Low")
	redirect '/todos' 
end

get '/change_status_out/:item' do
	@todo_item = TodoItem.find(params[:item])
	@todo_item.update(due_date: "All Out!")
	redirect '/todos'
end




