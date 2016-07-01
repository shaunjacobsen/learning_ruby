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

  def find_todos_for_list(list_id)
    get_todos = query("SELECT * FROM todos WHERE list_id = $1", list_id)
    retrieved_todos = get_todos.map do |todo|
      { id: todo['id'], name: todo['name'], completed: todo['completed'] == 't' }
    end
  end

  def find_list(id)
    result = query("SELECT lists.*, COUNT(todos.id) AS todos_count,
                   COUNT(NULLIF(todos.completed, true)) AS todos_remaining
                   FROM lists LEFT JOIN todos ON todos.list_id = lists.id WHERE lists.id = $1
                   GROUP BY lists.id
                   ORDER BY lists.name;", id)

    tuple_to_list_hash(result.first)
  end

  def all_lists
    result = query("SELECT lists.*, COUNT(todos.id) AS todos_count,
                   COUNT(NULLIF(todos.completed, true)) AS todos_remaining
                   FROM lists LEFT JOIN todos ON todos.list_id = lists.id GROUP BY lists.id
                   ORDER BY lists.name;")
    result.map do |tuple|
      tuple_to_list_hash(tuple)
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

  def create_new_todo(list_id, todo_name)
    query("INSERT INTO todos (list_id, name) VALUES ($1, $2)",
          list_id, todo_name)
  end

  def delete_todo_from_list(list_id, todo_id)
    query("DELETE FROM todos WHERE id = $1 AND list_id = $2", todo_id, list_id)
  end

  def update_todo_status(list_id, todo_id, status)
    query("UPDATE todos SET completed = $1 WHERE id = $2 AND list_id = $3",
          status, todo_id, list_id)
  end

  def mark_all_todos_as_completed(list_id)
    query("UPDATE todos SET completed = true WHERE list_id = $1", list_id)
  end

  private

  def tuple_to_list_hash(tuple)
    {
      id: tuple['id'].to_i,
      name: tuple['name'],
      todos_count: tuple['todos_count'].to_i,
      todos_remaining: tuple['todos_remaining'].to_i
    }
  end

end