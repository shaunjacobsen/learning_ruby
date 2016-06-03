require "sinatra"
require "sinatra/reloader" if development?
require "sinatra/content_for"
require "tilt/erubis"

# configuration

configure do
  enable :sessions
  set :session_secret, 'secret'
  set :erb, :escape_html => true
end

# routes

get "/" do
  erb :main, layout: :layout
end