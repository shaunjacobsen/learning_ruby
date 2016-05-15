require "tilt/erubis"
require "sinatra"
require "sinatra/reloader"

get "/" do
  @title = "The Adventures of Sherlock Holmes"
  @toc = File.readlines("data/toc.txt")
  erb :home
end

get "/chapters/:number" do
  @chapter_num = params[:number].to_i
  @toc = File.readlines("data/toc.txt")
  @chapter_name = @toc[@chapter_num - 1]
  @title = "Chapter #{@chapter_num}: #{@chapter_name}"
  @chapter = File.read("data/chp#{@chapter_num}.txt")

  erb :chapter
end