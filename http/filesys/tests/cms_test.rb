ENV["RACK_ENV"] = "test"

require "minitest/autorun"
require "rack/test"
require "fileutils"

require_relative "../cms"

class AppTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_index
    get "/"
    assert_equal 200, last_response.status
    assert_equal "text/html;charset=utf-8", last_response["Content-Type"]
    assert_includes last_response.body, "about.md"
    assert_includes last_response.body, "changes.txt"
    assert_includes last_response.body, "history.txt"
  end

  def test_text_document
    get "/read/history.txt"

    assert_equal 200, last_response.status
    assert_equal "text/plain;charset=utf-8", last_response["Content-Type"]
    assert_includes last_response.body, "2014 - Ruby 2.2 released."
  end

  def test_nonexistent_document
    get "/read/nothing.txt"

    assert_equal 302, last_response.status
    get last_response["Location"]

    assert_equal 200, last_response.status
    assert_includes last_response.body, "nothing.txt does not exist"
  end

  def test_markdown_file
    get "/read/about.md"

    assert_equal 200, last_response.status
    assert_equal "text/html;charset=utf-8", last_response["Content-Type"]
    assert_includes last_response.body, "with a few lines of text"
  end

  def test_updating_file
    post "/edit/changes.txt", contents: "I changed it"

    assert_equal 302, last_response.status

    get last_response["Location"]

    assert_includes last_response.body, "changes.txt updated"

    get "/read/changes.txt"
    assert_equal 200, last_response.status
    assert_includes last_response.body, "I changed it"
  end
end