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

  def setup
    FileUtils.mkdir_p(data_path)
  end

  def teardown
    FileUtils.rm_rf(data_path)
  end

  def create_document(name, content = "")
    File.open(File.join(data_path, name), 'w') do |file|
      file.write(content)
    end
  end

  def session
    last_request.env["rack.session"]
  end

  def admin_session
    { "rack.session" => { username: "admin" } }
  end

  def test_index
    create_document("about.md")
    create_document("changes.txt")

    get "/", {}, admin_session
    assert_equal 200, last_response.status
    assert_equal "text/html;charset=utf-8", last_response["Content-Type"]
    assert_includes last_response.body, "about.md"
    assert_includes last_response.body, "changes.txt"
  end

  def test_text_document
    get "/read/history.txt"

    assert_equal 302, last_response.status
    assert_equal "text/plain;charset=utf-8", last_response["Content-Type"]
    assert_includes last_response.body, "2014 - Ruby 2.2 released."
  end

  def test_nonexistent_document
    get "/read/nothing.txt"

    assert_equal 302, last_response.status
    assert_equal "nothing.txt does not exist.", session[:error]
  end

  def test_markdown_file
    get "/read/about.md"

    assert_equal 302, last_response.status
    assert_equal "text/html;charset=utf-8", last_response["Content-Type"]
    assert_includes last_response.body, "with a few lines of text"
  end

  def test_updating_file
    post "/edit/changes.txt", contents: "I changed it"

    assert_equal 302, last_response.status

    assert_equal "changes.txt updated.", session[:messages]

    get last_response["Location"]

    get "/read/changes.txt", {}, admin_session
    assert_equal 200, last_response.status
    assert_includes last_response.body, "I changed it"
  end

  def test_updating_file_if_logged_out
    create_document("changes.txt")
    post "/edit/changes.txt", contents: "I changed it"

    assert_equal 302, last_response.status

    assert_equal "You must be signed in to do that.", session[:error]
  end

  def test_deleting_file
    create_document("test.txt")
    post "/delete/test.txt"

    assert_equal 302, last_response.status
    assert_equal "test.txt has been deleted.", session[:messages]

    get last_response["Location"]

    get "/", {}, admin_session
    refute_includes last_response.body, "test.txt"
  end

  def test_deleting_file_if_logged_out
    create_document("test.txt")
    post "/delete/test.txt"

    assert_equal 302, last_response.status
    assert_equal "You must be signed in to do that.", session[:error]
  end

  def test_login_form
    get "/login"

    assert_equal 200, last_response.status
    assert_includes last_response.body, "<input"
    assert_includes last_response.body, "Log In"
  end

  def test_login
    post "/login", username: "admin", password: "secret"
    assert_equal 302, last_response.status

    assert_equal "Welcome!", session[:messages]

    get last_response["Location"]
    assert_equal "admin", session[:user]
  end

  def test_incorrect_login
    post "/login", username: "admin", password: "bad"
    assert_equal 302, last_response.status

    get last_response["Location"]

    assert_includes last_response.body, "Invalid Credentials"
    assert_equal nil, session[:user]
  end

  def test_logout
    post "/login", username: "admin", password: "secret"
    get last_response["Location"]
    assert_includes last_response.body, "Welcome"

    get "/logout"
    get last_response["Location"]

    assert_includes last_response.body, "You have been logged out"
    assert_equal nil, session[:user]
  end
end