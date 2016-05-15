require "tilt/erubis"
require "sinatra"
require "sinatra/reloader"

get "/" do # defaults to ascending order
  @title = "Home"
  @files = Dir.glob("public/*")

  erb :home
end

get "/sort/desc" do # show in reverse order
  @title = "Home"
  @files = Dir.glob("public/*")
  @files.reverse!

  erb :home
end