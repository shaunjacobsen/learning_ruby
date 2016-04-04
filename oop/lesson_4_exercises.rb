### Easy 1

# Question 1
# They are all objects. You can use '.class' on the objects to find out what class they belong to.

# Question 2
# Use 'include Speed' to mix the module into the class.

# Question 3
# self.class will print out the name of the class

# Question 4
# angry_cat = AngryCat.new

# Question 5
# Instance variables start with '@', so the Pizza class has an instance variable.

# Question 6
# add a 'get_volume' method that simply returns the instance variable

# Question 7
# It will print the object (e.g. "#<ThisClass:0x007faec20b4e10>")

# Question 8
# 'self' refers to the current object (the instance of the object)

# Question 9
# 'self' refers to the class (e.g. Cat)

# Question 10
# Bag.new('brown', 'canvas')

### Easy 2

# Question 1
# The string "You will " will be returned with one of the 3 options from the array.

# Question 2
# The string "You will " will be returned with one of the 3 options from the choices method in the RoadTrip class, not the Oracle class.

# Question 3
# Use the '.ancestors' method on the class to see the lookup chain. For Orange it will look in itself, then Taste, Object, Kernel, and BasicObject. For Hotsouce it is the same.

# Question 4
# 'attr_accessor :type' will create implicit getter and setter methods for @type.

# Question 5
# excited_dog is a local variable; @excited_dog is an instance variable; @@excited_dog is a class variable.

# Question 6
# 'self.manufacturer' is a class method; it is prefixed with 'self'.

# Question 7
# @@cats_count keeps track of the number of objects created (initialized) from the Cat class.

# Question 8
# class Bingo < Game

# Question 9
# The 'play' method in the Bingo class would override the one in the Game class, but only for instances of the Bingo class, since the method lookup chain will look first in Bingo, then in Game.

# Question 10
# Keeps code cleaner and more compartamentalized, DRYs up the code, easier to manage complexity.

### Easy 3

# Question 1
# Case 1: "Hello"
# Case 2: Error, undefined method
# Case 3: Error, wrong number of arguments
# Case 4: "Goodbye"
# Case 5: Error, undefined method

# Question 2
# To fix this, put 'self.' before 'hi' (line 8) and 'greet' (line 2)

# Question 3
# angry_cat_1 = AngryCat.new(3, "Grumpy")
# angry_cat_2 = AngryCat.new(5, "Crabby")

# Question 4
# Define a to_s method in the class:
# def to_s
#   "I am a #{type} cat."
# end

# Question 5
# tv.manufacturer does not work; there is no method defined on the instance, only the class.
# Television.model will also not work as there is no 'model' method on the class, only the instance.

# Question 6
# Replace 'self.' with '@'

# Question 7
# "Return", since ruby already returns the last line.

### Medium 1

# Question 1
# Ben is right, because the attr_reader contains the symbol :balance, which creates a getter method for @balance.

# Question 2
# 'attr_accessor' should be used on :quantity if you want to use the 'update_quantity' method, or you must use '@quantity = ' in the method.

# Question 3
# If you didn't want to allow @quantity to be re-set in the application, then there is a problem since changing attr_reader to attr_accessor will make updating the value possible.

# Question 4
class Greeting
  def greet(str)
    print str
  end
end

class Hello < Greeting
  def hi
    greet('Hello')
  end
end

class Goodbye < Greeting
  def bye
    greet('Goodbye')
  end
end

# Question 5
class KrispyKreme
  def initialize(filling_type="Plain", glazing)
    @filling_type = filling_type
    @glazing = glazing
  end

  def to_s
    @filling_type == nil ? @filling_type = "Plain" : nil
    if @glazing == nil
      "#{@filling_type}"
    else
      "#{@filling_type} with #{@glazing}"
    end
  end
end

donut1 = KrispyKreme.new(nil, nil)
donut2 = KrispyKreme.new("Vanilla", nil)
donut3 = KrispyKreme.new(nil, "sugar")
donut4 = KrispyKreme.new(nil, "chocolate sprinkles")
donut5 = KrispyKreme.new("Custard", "icing")

puts donut1
puts donut2
puts donut3
puts donut4
puts donut5

# Question 6
# There isn't a difference, the code works the same.

# Question 7
# Rename the 'light_information' method to 'information', since calling it requires writing 'Light.light_information', which is redundant.

### 

