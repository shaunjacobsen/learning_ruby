require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!

require 'simplecov'
SimpleCov.start

require_relative 'todos'

class TodoTest < Minitest::Test
  def setup
    @todo1 = Todo.new("Grocery shopping", "Milk, bread, cheese")
  end

  def test_initialize
    assert_equal(false, @todo1.done?)
    assert_equal("Grocery shopping", @todo1.title)
    assert_equal("Milk, bread, cheese", @todo1.description)
  end

  def test_undone!
    @todo1.done!
    assert_equal(true, @todo1.done?)
    @todo1.undone!
    assert_equal(false, @todo1.done?)
  end

  def test_to_s
    todo1_to_s = "[ ] Grocery shopping"
    assert_equal(todo1_to_s, @todo1.to_s)
  end

end

class TodoListTest < Minitest::Test

  def setup
    @todo1 = Todo.new("Buy milk")
    @todo2 = Todo.new("Clean room")
    @todo3 = Todo.new("Go to gym")
    @todos = [@todo1, @todo2, @todo3]

    @list = TodoList.new("Today's Todos")
    @list.add(@todo1)
    @list.add(@todo2)
    @list.add(@todo3)
  end

  def test_to_a
    assert_equal(@todos, @list.to_a)
  end

  def test_size
    assert_equal(3, @list.size)
  end

  def test_first
    assert_equal(@todo1, @list.first)
  end

  def test_last
    assert_equal(@todo3, @list.last)
  end

  def test_shift
    shifted = @list.shift
    assert_equal(shifted, @todo1)
    assert_equal([@todo2, @todo3], @list.to_a)
  end

  def test_pop
    popped = @list.pop
    assert_equal(popped, @todo3)
    assert_equal([@todo1, @todo2], @list.to_a)
  end

  def test_done?
    assert_equal(false, @list.done?)
  end

  def test_raises_type_error_on_creation
    assert_raises(TypeError) { @list.add("not a Todo object") }
  end

  def test_add_alias
    new_todo = Todo.new("Learn to program")
    @list << new_todo # add to the @list instance variable
    todos = @todos << new_todo # add to the actual todos list object

    assert_equal(todos, @list.to_a)
  end

  def test_item_at
    assert_raises (IndexError) { @list.item_at(5) }
    assert_equal(@todo1, @list.item_at(0))
  end

  def test_mark_done_at
    assert_raises (IndexError) { @list.mark_done_at(5) }
    @list.mark_done_at(0)
    assert_equal(true, @todo1.done?)
    assert_equal(false, @todo2.done?)
  end

  def test_mark_undone_at
    assert_raises (IndexError) { @list.mark_undone_at(5) }
    @todo1.done!
    @list.mark_undone_at(0)
    assert_equal(false, @todo1.done?)
    assert_equal(false, @todo1.done?)
  end

  def test_done!
    @list.done!
    assert_equal(true, @todo1.done?)
    assert_equal(true, @todo2.done?)
    assert_equal(true, @todo3.done?)
    assert_equal(true, @list.done?)
  end

  def test_remove_at
    assert_raises (IndexError) { @list.remove_at(5) }
    @list.remove_at(0)
    assert_equal(@list.to_a, [@todo2, @todo3])
  end

  def test_to_s
    output = <<-OUTPUT.chomp.gsub /^\s+/, ""
    ---- Today's Todos ----
    [ ] Buy milk
    [ ] Clean room
    [ ] Go to gym
    OUTPUT

    assert_equal(output, @list.to_s)

    @list.mark_done_at(0)

    output = <<-OUTPUT.chomp.gsub /^\s+/, ""
    ---- Today's Todos ----
    [X] Buy milk
    [ ] Clean room
    [ ] Go to gym
    OUTPUT

    assert_equal(output, @list.to_s)

    @list.done!

    output = <<-OUTPUT.chomp.gsub /^\s+/, ""
    ---- Today's Todos ----
    [X] Buy milk
    [X] Clean room
    [X] Go to gym
    OUTPUT

    assert_equal(output, @list.to_s)

  end

  def test_each
    results = []
    @list.each { |todo| results << todo }
    assert_equal(results, [@todo1, @todo2, @todo3])
  end

  def test_each_original_object_returned
    assert_equal(@list.each { |todo| }, @list)
  end

  def select
    @todo1.done!
    assert_equal(@list.select { |todo| todo.done? }, @todo1)
  end

end


