# 1. Objects are created from classes. Many different objects can be created from the same class. Behaviors and variables are stored in each instance of the class created, an object.
class City
  def initialize(name)
    @name = name
  end
end

paris = City.new('Paris')

# 2. Classes can inherit from each other so that "child" classes inherit behaviors from the parent classes. This helps DRY up the code (avoids repetition):
class Animal
  def initialize(name)
    @name = name
  end

  def speak
    "growl"
  end
end

class Dog < Animal # inherit from the Animal class
  def speak
    "bark" # this overrides the default 'speak' method all Animals have
  end
end

# 3. Ruby uses modules to solve the multiple inheritance issue. When using modules, Ruby will first look in the object's class, then in any modules, THEN in any parent classes.
module Walkable
  def can_walk?
    true
  end
end

class Cat < Animal
  include Walkable

  def speak
    "meow"
  end
end

puts Cat.ancestors
# should print:
# Cat
# Walkable
# Animal
# Object

# 4. Modules can be "mixed in" to many different classes, but classes can only inherit from one class. Also, modules cannot be created like classes (instantiation).

# 5. Object-Oriented Programming helps contain large software in manageable "chunks" (encapsulation) so that the likelihood of changes in one part of the programming reverberating throughout the rest of the program are minimized. The use of modules and inheritance also helps with DRYing up the code, i.e. avoiding repetition, which also makes the program easier to mantain. In terms of cons, OOP has a steep learning curve, and initiating a project can be difficult when envisioning how everything will work together.

# 6. Ovject-Oriented Design are the concepts behind object-oriented programming, such as encapsulation and inheritance, that a programmer uses to plan out the program. OO Design includes tenets such as reusability of code, inheritance of classes, encapsulation (classes), protecting the data within the program from other parts of the program (or the public interface), and good naming conventions that ensure future readability and maintainability of the code.

# 7. On line 9, the instance variable is not being re-written:
def change_info(new_name)
  @name = new_name
end

# or use 'self'

def change_info(new_name)
  self.name = new_name
end

# 8.
class Person
  @@no_people = 0

  def initialize(name, weight, height)
    @name = name
    @weight = weight
    @height = height
    @@no_people += 1
  end

  def self.total_people
    @@no_people
  end
end

# 9. 
class Person
  attr_accessor :name, :weight, :height
  @@no_people = 0

  def initialize(name, weight, height)
    @name = name
    @weight = weight
    @height = height
    @@no_people += 1
  end

  def self.total_people
    @@no_people
  end
end

# 10.
class Person
  attr_accessor :name, :weight, :height
  @@no_people = 0

  def initialize(name, weight, height)
    @name = name
    @weight = weight
    @height = height
    @@no_people += 1
  end

  def change_info(new_name, new_weight, new_height)
    self.name = new_name
    self.weight = new_weight
    self.height = new_height
  end

  def self.total_people
    @@no_people
  end
end

# 11. `self`, when called on a method in the class, refers to the class itself (a class method). In the case of invoking an instance method, it is referring to the instances created in that object. `self` points to the object currently in execution.

# 12.
class Employee
  def initialize(classification, pto, location, name)
    @classification = classification  # part-time or full-time
    @pto = pto  # vacation time
    @desk = location
    @name = name
  end

  def to_s
    @name
  end

end

module Delegateable
  def assigns_work?
    true
  end
end

class Manager < Employee
  include Delegateable

  def initialize(name)
    super('FT', 14, 'Private Office', name)
  end

  def to_s
    "Mgr #{@name}"
  end

end

class Executive < Employee
  include Delegateable

  def initialize(name)
    super('FT', 20, 'Corner Private Office', name)
  end

  def to_s
    "Exe #{@name}"
  end
end

# 13. Closures are a block of code that can be passed into methods for execution at runtime, giving programmers greater flexibility in what a method can do.

# 14. We can create methods that are open-ended (e.g. defer what is done in the method):
def add_five(num)
  yield(num + 5)
end

add_five(10) { |number| puts number }
add_five(10) { |number| number ** 2 }

# Methods can also be used for before/after cases:
def compare_changes(input)
  puts "Before: #{input}"
  changed = yield(input)
  puts "After: #{changed}"
end

compare_changes(5) { |num| num ** 2 }

# 15. rspec allows programmers to write code that is more 'natural' (in terms of English), where as Minitest is straightforward (it uses Ruby syntax).

# 16. `assert_equal` takes two parameters and compares the two using '==', so it depends on what is being compared. If it is two String objects, it will compare their contents. If it's two Objects (but not Strings, for example), it will compare their identites (object ids).