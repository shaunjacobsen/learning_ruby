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