### Lecture: Classes and Objects

# class Person
#   attr_accessor :first_name, :last_name

#   def initialize(name)
#     parse_full_name(name)
#   end

#   def name
#     "#{@first_name} #{@last_name}"
#   end

#   def name=(name)
#     parse_full_name(name)
#   end

#   def to_s
#     name
#   end

#   private

#   def parse_full_name(name)
#     name_parts = name.split
#     self.first_name = name_parts.first
#     self.last_name = name_parts.size > 1 ? name_parts.last : ''
#   end
# end

# bob = Person.new('Robert Smith')
# rob = Person.new('Robert Smith')

# puts "The person's name is #{bob}"


### Lecture: Inheritance

class Dog
  def speak
    'bark!'
  end

  def swim
    'swimming!'
  end
end

class Bulldog < Dog
  def swim
    "can't swim!"
  end
end

teddy = Dog.new
puts teddy.speak
puts teddy.swim
frenchie = Bulldog.new
puts frenchie.speak
puts frenchie.swim