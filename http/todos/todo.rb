require "sinatra"
require "sinatra/reloader"
require "sinatra/content_for"
require "tilt/erubis"

# configuration

configure do
  enable :sessions
  set :session_secret, 'secret'
end

before do
  session[:lists] ||= []
end

# routes

get "/" do
  redirect "/lists"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
end

# view all lists
get "/lists" do
  @lists = session[:lists]
  erb :lists, layout: :layout
end

# view a specific list
get "/lists/:id" do
  id = params[:id].to_i
  @list = session[:lists][id]
  erb :list, layout: :layout
end

# return an error message if the name is invalid; return nil if name is valid
def error_for_list_name(name)
  if session[:lists].any? { |list| list[:name] == name }
    "The list name must be unique; #{name} already exists."
  elsif !(1..100).cover? name.size
    "The list name must be between 1 and 100 characters"
  end
end

# creates a new list
post "/lists" do
  list_name = params[:list_name].strip
  error = error_for_list_name(list_name)
  if error
    session[:error] = error
    erb :new_list, layout: :layout
  else
    session[:lists] << { name: list_name, todos: [] }
    session[:success] = "The list \"#{list_name}\" has been created."
    redirect "/lists"
  end
end

# renders new list form
get "/lists/new" do
  erb :new_list, layout: :layout
end

# edit an existing to-do list
get "/lists/:id/edit" do
  id = params[:id].to_i
  @list = session[:lists][id]
  erb :edit_list, layout: :layout
end

# update an existing to-do list
post "/lists/:id" do
  list_name = params[:list_name].strip
  id = params[:id].to_i
  @list = session[:lists][id]

  error = error_for_list_name(list_name)
  if error
    session[:error] = error
    erb :edit_list, layout: :layout
  else
    @list[:name] = list_name
    session[:success] = "The list \"#{list_name}\" has been updated."
    redirect "/lists"
  end
end

# delete an existing to-do list
post '/lists/:id/destroy' do
  id = params[:id].to_i
  session[:lists].delete_at(id)
  session[:success] = "List has been deleted."
  redirect "/lists"
end
