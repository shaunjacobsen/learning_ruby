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

before do
  @files = Dir.glob("data/*").map do |path|
    File.basename(path)
  end
end

helpers do
  def paragraphify(text)
    text.gsub("\n", "<br />")
  end

end

# routes

get "/" do
  erb :index, layout: :layout
end

get "/read/:filename" do
  content_type :text
  filename = params[:filename]
  file = File.open("data/#{filename}").read
  return file
end