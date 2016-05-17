require "tilt/erubis"
require "sinatra"
require "sinatra/reloader"
require "yaml"

helpers do
  def count_interests(hash)
    interests = []
    hash.each do |_, v|
      interests << v[:interests]
    end
    interests.flatten!
  end
end

before do
  @users = YAML.load_file('users.yaml')
  @num_interests = count_interests(@users).size
end

not_found do
  redirect "/"
end

get "/" do
  @title = "Users"

  erb :home
end

get "/user/:name" do
  @title = params[:name]
  @active_user = @users.select { |k, v| k.to_s == params[:name] }.first
  @info = @active_user
  @username = @info.first
  @email = @info[1][:email]
  @interests = @info[1][:interests].join(", ")

  erb :user
end