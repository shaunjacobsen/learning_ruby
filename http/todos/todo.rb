require "sinatra"
require "sinatra/content_for"
require "tilt/erubis"

require_relative "database_persistence"

# configuration

configure do
  enable :sessions
  set :session_secret, 'secret'
  set :erb, :escape_html => true
end

configure(:development) do
  require 'sinatra/reloader'
  also_reload 'database_persistence.rb'
end

# helpers

helpers do
  def list_complete?(list)
    todos_count(list) > 0 && todos_remaining_count(list) == 0
  end

  def list_class(list)
    "complete" if list_complete?(list)
  end

  def todos_count(list)
    list[:todos].size
  end

  def todos_remaining_count(list)
    list[:todos].count { |todo| !todo[:completed] }
  end

  def sort_lists(lists, &block)
    complete_lists, incomplete_lists = lists.partition { |list| list_complete?(list) }

    incomplete_lists.each(&block)
    complete_lists.each(&block)
  end

  def sort_todos(todos, &block)
    complete_todos, incomplete_todos = todos.partition { |todo| todo[:completed] }

    incomplete_todos.each(&block)
    complete_todos.each(&block)
  end
end

def load_list(id)
  list = @storage.find_list(id)
  return list if list

  session[:error] = "The specified list was not found."
  redirect "/lists"
  halt
end

# before

before do
  @storage = DatabasePersistence.new(logger)
end

# routes

get "/" do
  redirect "/lists"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
end

# view all lists
get "/lists" do
  @lists = @storage.all_lists
  erb :lists, layout: :layout
end

# renders new list form
get "/lists/new" do
  erb :new_list, layout: :layout
end

# view a specific list
get "/lists/:id" do
  @list_id = params[:id].to_i
  @list = load_list(@list_id)
  erb :list, layout: :layout
end

# return an error message if the name is invalid; return nil if name is valid
def error_for_list_name(name)
  if @storage.all_lists.any? { |list| list[:name] == name }
    "The list name must be unique; #{name} already exists."
  elsif !(1..100).cover? name.size
    "The list name must be between 1 and 100 characters"
  end
end

# return an error message if the name is invalid; return nil if name is valid
def error_for_todo(name)
  if !(1..100).cover? name.size
    "The todo name must be between 1 and 100 characters"
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
    @storage.create_new_list(list_name)
    session[:success] = "The list has been created."
    redirect "/lists"
  end
end

# edit an existing to-do list
get "/lists/:id/edit" do
  id = params[:id].to_i
  @list = load_list(id)
  erb :edit_list, layout: :layout
end

# update an existing to-do list
post "/lists/:id" do
  list_name = params[:list_name].strip
  id = params[:id].to_i
  @list = load_list(id)

  error = error_for_list_name(list_name)
  if error
    session[:error] = error
    erb :edit_list, layout: :layout
  else
    @storage.update_list_name(id, list_name)
    session[:success] = "The list \"#{list_name}\" has been updated."
    redirect "/lists/#{id}"
  end
end

# delete an existing to-do list
post '/lists/:id/destroy' do
  id = params[:id].to_i

  @storage.delete_list(id)

  if env["HTTP_X_REQUESTED_WITH"] == "XMLHttpRequest"
    "/lists"
  else
    session[:success] = "List has been deleted."
    redirect "/lists"
  end
end

# add a new to-do to a to-do list
post '/lists/:list_id/todos' do
  @list_id = params[:list_id].to_i
  @list = load_list(@list_id)
  text = params[:todo].strip

  error = error_for_todo(text)
  if error
    session[:error] = error
    erb :list, layout: :layout
  else
    @storage.create_new_todo(@list_id, text)
    session[:success] = "The todo was added"
    redirect "/lists/#{@list_id}"
  end
end

# delete a to-do from a to-do list
post '/lists/:list_id/todos/:id/destroy' do
  @list_id = params[:list_id].to_i
  @list = load_list(@list_id)
  @storage.delete_todo_from_list(list_id, todo_id)
  if env["HTTP_X_REQUESTED_WITH"] == "XMLHttpRequest"
    status 204
  else
    session[:success] = "The todo has been deleted."
    redirect "/lists/#{@list_id}"
  end
end

# mark a to-do completed or not
post '/lists/:list_id/todos/:id' do
  @list_id = params[:list_id].to_i
  @list = load_list(@list_id)

  todo_id = params[:id].to_i
  is_completed = params[:completed] == "true"
  @storage.update_todo_status(@list_id, todo_id, is_completed)

  session[:success] = "The todo has been updated."
  redirect "/lists/#{@list_id}"
end

# mark all to-dos in a list completed
post '/lists/:id/complete_all' do
  @list_id = params[:id].to_i
  @list = load_list(@list_id)
  @storage.mark_all_todos_as_completed(@list_id)

  session[:success] = "All to-dos marked completed!"
  redirect "lists/#{@list_id}"
end
