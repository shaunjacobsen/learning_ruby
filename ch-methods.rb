# 1
# Write a program that prints a greeting message. This program should contain a method called greeting that takes a name as its parameter and returns a string.

def greeting(name)
  puts "Howdy, #{name}."
end

puts "---\n#1\n---"
greeting("Shaun")

# 2
# What do the following expressions evaluate to?

puts "---\n#2\n---"
puts "2"
puts "nil"
puts "Joe"
puts "four"
puts "nil"

# 3
# Write a program that includes a method called multiply that takes two arguments and returns the product of the two numbers.

def multiply(n1,n2)
  return n1 * n2
end

puts "---\n#3\n---"
puts multiply(3,4)

# 4
# What will the following code print to the screen?

puts "---\n#4\n---"
puts "Nothing"

# 5
# 1) Edit the method in exercise #4 so that it does print words on the screen. 2) What does it return now?

def scream(words)
  words = words + "!!!!"
  puts words
end

puts "---\n#5\n---"
scream("Yippeee")

# 6
# What does the following error message tell you?

puts "---\n#6\n---"
puts "The calculate_product method needs two arguments, but only one was passed in."