require "tilt/erubis"
require "sinatra"
require "sinatra/reloader"

get "/" do
  @title = "This is the title"
  erb :home
end
