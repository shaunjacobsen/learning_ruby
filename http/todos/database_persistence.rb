require 'pg'

class DatabasePersistence

  def initialize(logger)
    @db = PG.connect(dbname: 'todos')
    @logger = logger
  end

  def query(statement, *params)
    @logger.info "#{statement}: #{params}"
    @db.exec_params(statement, params)
  end

  def find_list(id)
    result = query("SELECT * FROM lists WHERE id = $1", id)

    tuple = result.first

    list_id = tuple['id'].to_i
    retrieved_todos = find_todos_for_list(list_id)
    { id: list_id, name: tuple['name'], todos: retrieved_todos }
  end

  def all_lists
    result = query("SELECT * FROM lists;")
    result.map do |tuple|
      list_id = tuple['id'].to_i
      retrieved_todos = find_todos_for_list(list_id)
      { id: list_id, name: tuple['name'], todos: retrieved_todos }
    end
  end

  def create_new_list(list_name)
    query("INSERT INTO lists (name) VALUES ($1)", list_name)
  end

  def delete_list(id)
    query("DELETE FROM todos WHERE list_id = $1", id)
    query("DELETE FROM lists WHERE id = $1", id)
  end

  def update_list_name(id, new_name)
    query("UPDATE lists SET name = $1 WHERE id = $2", new_name, id)
  end

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

  private

  def find_todos_for_list(list_id)
    get_todos = query("SELECT * FROM todos WHERE list_id = $1", list_id)
    retrieved_todos = get_todos.map do |todo|
      { id: list_id, name: todo['name'], completed: todo['completed'] == 't' }
    end
  end

end