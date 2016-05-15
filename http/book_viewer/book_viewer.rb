require "tilt/erubis"
require "sinatra"
require "sinatra/reloader"

helpers do
  def in_paragraphs(text)
    text.split("\n\n").map do |line|
      "<p>#{line}</p>"
    end.join
  end
end

before do
  @toc = File.readlines("data/toc.txt")
end

get "/" do
  @title = "The Adventures of Sherlock Holmes"
  erb :home
end

get "/chapters/:number" do
  @chapter_num = params[:number].to_i
  @chapter_name = @toc[@chapter_num - 1]
  @title = "Chapter #{@chapter_num}: #{@chapter_name}"
  @chapter = File.read("data/chp#{@chapter_num}.txt")

  erb :chapter
end

not_found do
  redirect "/"
end