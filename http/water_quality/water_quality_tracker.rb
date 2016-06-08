require "sinatra"
require "sinatra/reloader" if development?
require "sinatra/content_for"
require "tilt/erubis"
require "yaml"

configure do
  enable :sessions
  set :session_secret, 'secret'
  set :erb, :escape_html => true
end

before do
  @tracking_data = YAML.load(File.open('data.yml'))
end

helpers do
  def parse_date_day_month_year(date)
    date.strftime('%-d %B %Y')
  end

  def parse_time_from_date(date)
    date.strftime('%H:%M')
  end
end

get "/" do
  erb :index, layout: :layout
end

get "/entry/new" do
  @last_id = @tracking_data.keys.last
  if @tracking_data.keys.include? (@last_id + 1)
    session[:error] = "There was an error creating a new log entry."
  else
    @next_id = @last_id + 1
  end
  @today = Time.now

  erb :new, layout: :layout
end

post "/entry/new" do
  data = {
    @next_id => {
      'date' => params[:date]
      'pH' => params[:pH]
      'temp' => params[:temp]
      'ammonia' => params[:ammonia]
      'nitrites' => params[:nitrites]
      'nitrates' => params[:nitrates]
      'notes' => params[:notes]
    }
  }
  File.open('data.yml', 'w') { |f| f.write(data.to_yaml) }
end

get "/entry/:id" do
  id = params[:id].to_i
  if @tracking_data.has_key?(id)
    @selected_data = @tracking_data.fetch(id)
  else
    session[:error] = "Cannot find data."
  end
  erb :detail, layout: :layout
end
