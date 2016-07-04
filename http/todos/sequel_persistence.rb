require 'sequel'

class SequelPersistence

  def initialize(logger)
    @db = Sequel.connect('postgres://localhost/todos')
    @db.loggers << logger
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
    @db[:lists].insert(name: list_name)
  end

  def delete_list(id)
    @db[:todos].where(list_id: id).delete
    @db[:lists].where(id: id).delete
  end

  def update_list_name(id, new_name)
    @db[:lists].where(id: id).update(name: new_name)
  end

  def create_new_todo(list_id, todo_name)
    @db[:todos].insert(list_id: list_id, name: todo_name)
  end

  def delete_todo_from_list(list_id, todo_id)
    @db[:todos].where(id: todo_id, list_id: list_id).delete
  end

  def update_todo_status(list_id, todo_id, status)
    @db[:todos].where(id: todo_id, list_id: list_id).update(completed: status)
  end

  def mark_all_todos_as_completed(list_id)
    @db[:todos].where(list_id: list_id).update(completed: true)
  end

end