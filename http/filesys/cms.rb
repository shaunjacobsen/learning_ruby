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

helpers do
  def paragraphify(text)
    text.gsub("\n", "<br />")
  end

  def render_markdown(text)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
    markdown.render(text)
  end

end

# routes

get "/" do
  erb :index, layout: :layout
end

get "/read/*.*" do |path, ext|
  filename = path
  filetype = ext
  filepath = "data/#{filename}.#{filetype}"
  if File.exist?(filepath)
    case filetype
    when 'txt'
      content_type :text
      File.read(filepath)
    when 'md'
      render_markdown(File.read(filepath))
    end
  else
    session[:error] = "#{filename}.#{filetype} does not exist."
    redirect "/"
  end
end