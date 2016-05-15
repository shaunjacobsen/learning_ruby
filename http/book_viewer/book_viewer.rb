require "tilt/erubis"
require "sinatra"
require "sinatra/reloader"

helpers do
  def in_paragraphs(text)
    text.split("\n\n").each_with_index.map do |line, index|
      "<p id='p#{index + 1}'>#{line}</p>"
    end.join
  end

  def highlight_search_terms(text, paragraph)
    paragraph.gsub(text, "<span class='highlight'>#{text}</span>")
  end
end

before do
  @toc = File.readlines("data/toc.txt")
end

not_found do
  redirect "/"
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

get "/search" do
  if params[:query]
    @results = @toc.each_with_index.each_with_object([]) do |(chapter, index), results|
      text = File.read("data/chp#{index + 1}.txt")
      paragraphs = text.split("\n\n")
      paragraphs.each_with_index do |paragraph, paragraph_index|
        if paragraph.include?(params[:query])
          results << [chapter, index, paragraph, paragraph_index]
        end
      end
    end
  end

  erb :search
end