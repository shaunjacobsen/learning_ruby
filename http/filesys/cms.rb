require "sinatra"
require "sinatra/reloader" if development?
require "sinatra/content_for"
require "tilt/erubis"
require "redcarpet"

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

def data_path(path)
  if ENV["RACK_ENV"] == "test"
    "test/#{path}"
  else
    path
  end
end

helpers do
  def paragraphify(text)
    text.gsub("\n", "<br />")
  end

  def render_markdown(text)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
    markdown.render(text)
  end

  def valid_filetype?(filename)
    %w(txt md).include? filename.split(".").last
  end

  def filename_taken?(filename)
    @files.include? filename
  end

  def valid_filename?(filename)
    filename.strip.length > 0 && !filename_taken?(filename) && valid_filetype?(filename)
  end
end

# routes

get "/" do
  erb :index, layout: :layout
end

get "/read/*.*" do |path, ext|
  filename = path
  filetype = ext
  filepath = data_path("data/#{filename}.#{filetype}")
  if File.exist?(filepath)
    case filetype
    when 'txt'
      content_type :text
      @parsed_file = File.read(filepath)
    when 'md'
      render_markdown(File.read(filepath))
    end
  else
    session[:error] = "#{filename}.#{filetype} does not exist."
    redirect "/"
  end
end

get "/edit/:file" do
  @filename = params[:file]
  filepath = data_path("data/#{@filename}")
  @contents = File.read(filepath)
  erb :edit, layout: :layout
end

post "/edit/:file" do
  filename = params[:file]
  filepath = data_path("data/#{filename}")
  new_contents = params[:contents]
  rewrite_file = File.open(filepath, "w") do |file|
    file.write new_contents
  end
  if rewrite_file
    session[:messages] = "#{filename} updated."
    redirect "/"
  else
    session[:error] = "There was an error updating #{filename}."
  end
end

get "/new" do
  erb :new, layout: :layout
end

post "/new" do
  filename = params[:filename]
  if valid_filename?(filename)
    f = File.new("data/#{filename}", "w")
    redirect "/"
  else
    session[:error] = "#{filename} is not a valid filename."
    redirect "/new"
  end
end

post "/delete/:filename" do
  filename = params[:filename]
  filepath = data_path("data/#{filename}")
  File.delete(filepath)
  session[:messages] = "#{filename} has been deleted."
  redirect "/"
end


