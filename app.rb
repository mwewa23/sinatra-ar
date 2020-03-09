require "sinatra"
require "sinatra/reloader"
require "sinatra/activerecord"
set :database, { adapter: "sqlite3", database: "mydb.db" }

require './models/user'

get '/' do
   @users = User.all
   erb :user_list
end

get '/new' do
    erb :user_form
end

get '/remove' do
    erb :user_delete
end

post '/create' do
    user = User.new(name: params[:name],email: params[:email])
    user.save
    "The user, #{user.name} with  id: #{user.id} and email: #{user.email} has been created."
end

post '/delete' do
    user = User.find_by(name: params[:name])
    if !user.nil?
    user.destroy
        "The user, #{params[:name]} has been deleted"
    else
        "The user, #{params[:name]} was not found"
    end
end