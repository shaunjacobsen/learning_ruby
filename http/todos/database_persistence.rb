require 'pg'

class DatabasePersistence

  def initialize
    @db = PG.connect(dbname: 'todos')
  end

  def query(statement, *params)
    puts "#{statement}: #{params}"
    @db.exec_params(statement, params)
  end

  def find_list(id)
    result = query("SELECT * FROM lists WHERE id = $1", id)
    tuple = result.first
    { id: tuple['id'], name: tuple['name'], todos: [] }
  end

  def all_lists
    result = query("SELECT * FROM lists;")
    result.map do |tuple|
      { id: tuple['id'], name: tuple['name'], todos: [] }
    end
  end

  # def create_new_list(list_name)
  #   id = next_element_id(@session[:lists])
  #   @session[:lists] << { id: id, name: list_name, todos: [] }
  # end

  # def delete_list(id)
  #   @session[:lists].reject! { |list| list[:id] == id }
  # end

  # def update_list_name(id, new_name)
  #   list = find_list(id)
  #   list[:name] = list_name
  # end

  # def create_new_todo(list_id, todo_name)
  #   list = find_list(list_id)
  #   id = next_element_id(list[:todos])
  #   list[:todos] << { id: id, name: todo_name, completed: false }
  # end

  # def delete_todo_from_list(list_id, todo_id)
  #   list = find_list(list_id)
  #   list[:todos].reject! { |todo| todo[:id] == todo_id }
  # end

  # def update_todo_status(list_id, todo_id, status)
  #   list = find_list(list_id)
  #   todo = list[:todos].find { |t| t[:id] == todo_id }
  #   todo[:completed] = status
  # end

  # def mark_all_todos_as_completed(list_id)
  #   list = find_list(list_id)
  #   list[:todos].each do |todo|
  #     todo[:completed] = true
  #   end
  # end

end