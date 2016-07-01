require "sinatra"
require "sinatra/content_for"
require "tilt/erubis"
require "yaml"
require "time"

require_relative 'database'

configure do
  enable :sessions
  set :session_secret, 'secret'
  set :erb, :escape_html => true
end

configure(:development) do
  require 'sinatra/reloader'
  require 'pry'
  also_reload 'database.rb'
end

before do
  @storage = Database.new(logger)
  @tracking_data = @storage.all_entries
end

helpers do
  def parse_date_day_month_year(date)
    new_date = Time.parse(date)
    new_date.strftime("%-d %B %Y")
  end

  def parse_time_from_date(date)
    new_date = Time.parse(date)
    new_date.strftime("%H:%M")
  end
end

def change?(data)
  data.to_f == 0.0 ? "–" : data
end

def compare_with_previous(figure, current_id)
  current_id = current_id.to_i - 1
  current_data = @tracking_data[current_id]
  previous_id = current_id > 0 ? current_id.to_i - 1 : 0
  previous_data = @tracking_data[previous_id]
  # binding.pry
  if previous_data
    comparison = current_data[figure].to_f - previous_data[figure].to_f
  end
  comparison ? change?(comparison.round(1)) : nil
end

def determine_arrow(figure, current_id)
  comparison = compare_with_previous(figure, current_id).to_f
  if !comparison.nil?
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
  erb :new, layout: :layout
end

post "/entry/new" do
  @storage.new_entry(params[:pH], params[:temp], params[:ammonia], params[:nitrites], params[:nitrates], params[:notes])
  redirect "/"
end

get "/entry/edit/:id" do
  @id = params[:id].to_i
  if @storage.get_entry(@id)
    @selected_data = @storage.get_entry(@id)
  else
    session[:error] = "Cannot find data."
  end
  erb :edit, layout: :layout
end

post "/entry/edit" do
  @storage.update_entry(params[:id].to_i, params[:pH], params[:temp], params[:ammonia], params[:nitrites], params[:nitrates], params[:notes])
  redirect "/entry/#{params[:id]}"
end

get "/entry/:id" do
  @id = params[:id].to_i
  array_id = @id - 1
  if !@tracking_data[array_id].nil?
    #binding.pry
    @selected_data = @storage.get_entry(@id)
  else
    session[:error] = "Cannot find data."
  end
  erb :detail, layout: :layout
end
