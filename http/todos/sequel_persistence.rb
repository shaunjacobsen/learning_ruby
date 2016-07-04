require 'sequel'

class SequelPersistence

  def initialize(logger)
    @db = Sequel.connect('postgres://localhost/todos')
    @db.loggers << logger
  end

  def query(statement, *params)
    @logger.info "#{statement}: #{params}"
    @db.exec_params(statement, params)
  end

  def find_todos_for_list(list_id)
    @db[:todos].where(list_id: list_id)
  end

  def find_list(id)
    all_lists.where(lists__id: id).first
  end

  def all_lists
    @db[:lists].left_join(:todos, list_id: :id)
      .select_all(:lists)
      .select_append do
        [ count(todos__id).as(todos_count),
        count(nullif(todos__completed, true)).as(todos_remaining) ]
      end
      .group(:lists__id)
      .order(:lists__name)
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