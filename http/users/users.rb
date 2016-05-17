require "tilt/erubis"
require "sinatra"
require "sinatra/reloader"
require "yaml"

before do
  @users = YAML.load_file('users.yaml').to_h
end

get "/" do
  @title = "Users"
  erb :home
end