require "sinatra"
require "sinatra/reloader" if development?
require "sinatra/content_for"
require "tilt/erubis"
require "yaml"
require "csv"
require "json"

configure do
  enable :sessions
  set :session_secret, 'secret'
  set :erb, :escape_html => true
end

before do
  @tracking_data = YAML.load(File.open('data.yml'))
  @tracking_data = @tracking_data.sort.to_h
end

helpers do
  def parse_date_day_month_year(date)
    date.strftime("%-d %B %Y")
  end

  def parse_time_from_date(date)
    date.strftime("%H:%M")
  end
end

def compare_with_previous(figure, current_id)
  current_data = @tracking_data[current_id]
  previous_id = current_id.to_i - 1
  previous_data = @tracking_data[previous_id]
  if previous_data
    comparison = current_data[figure].to_f - previous_data[figure].to_f
    if comparison > 0
      "fa-arrow-up"
    elsif comparison < 0
      "fa-arrow-down"
    else
      ""
    end
  end

end

def is_valid_pH?(pH)
  pH > 0 && pH <= 9
end

def is_valid_ppm?(ppm_figure)
  ppm_figure >= 0 && ppm_figure < 10
end

def is_valid_temp?(temperature)
  temperature > 0 && temperature < 100
end

def valid_entry?(pH, ppm, temp)
  is_valid_pH?(pH) && is_valid_ppm?(ppm) && is_valid_temp?(temp)
end

def data_to_csv(metric_to_export)
  export = [['date','figure']]
  @tracking_data.each do |k, v|
    export << [v['date'], v[metric_to_export]]
  end
  File.open('public/chart_data.csv', 'w') { |f| f.write(export.inject([]) { |csv, row| csv << CSV.generate_line(row) }.join(""))}
end

def data_to_json
  @tracking_data.values.to_json
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
    params[:new_id].to_i => {
      "date" => Time.parse(params[:date]),
      "pH" => params[:pH],
      "temp" => params[:temp],
      "ammonia" => params[:ammonia],
      "nitrites" => params[:nitrites],
      "nitrates" => params[:nitrates],
      "notes" => params[:notes]
    }
  }
  combined_data = @tracking_data.merge(data)
  File.write('data.yml', combined_data.to_yaml)
  redirect "/"
end

get "/entry/edit/:id" do
  @id = params[:id].to_i
  if @tracking_data.has_key?(@id)
    @selected_data = @tracking_data.fetch(@id)
  else
    session[:error] = "Cannot find data."
  end
  erb :edit, layout: :layout
end

post "/entry/edit" do
  data = {
    params[:id].to_i => {
      "date" => Time.parse(params[:date]),
      "pH" => params[:pH],
      "temp" => params[:temp],
      "ammonia" => params[:ammonia],
      "nitrites" => params[:nitrites],
      "nitrates" => params[:nitrates],
      "notes" => params[:notes]
    }
  }
  remove_edited_entry = @tracking_data.reject { |k, _| k == params[:id] }
  combined_data = remove_edited_entry.merge(data)
  File.write('data.yml', combined_data.to_yaml)
  redirect "/entry/#{params[:id]}"
end

get "/entry/:id" do
  @id = params[:id].to_i
  if @tracking_data.has_key?(@id)
    @selected_data = @tracking_data.fetch(@id)
  else
    session[:error] = "Cannot find data."
  end
  erb :detail, layout: :layout
end
