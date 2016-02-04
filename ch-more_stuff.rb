# Intro to Programming
# More Stuff
# Exercise Answers

# Exercise 1
# Write a program that checks if the sequence of characters
# "lab" exists in the following strings. If it does exist,
# print out the word. - "laboratory" - "experiment" - "Pans Labyrinth" - "elaborate" - "polar bear"

def contains?(word)
  if word.length > 0
    if /lab/ =~ word
      puts "#{word} contains the string 'lab'"
    else
      puts "Not in that word."
    end
  else
    puts "Please specify a word."
  end
end

contains?("laboratory")
contains?("experiment")
contains?("Pans Labyrinth")
contains?("elaborate")
contains?("polar bear")
contains?("")

# 2
# What will the following program print to the screen?
# What will it return?

puts "Nothing."

# 3
# What is exception handling and what problem does it solve?

puts "Exception handling is a way to prevent an error in a script from stopping the rest of the script from running, using the 'rescue' logic."

# 4
# Modify the code in exercise 2 to make the block execute properly.

def execute(&block)
  block.call
end

execute { puts "Hello from inside the execute method!" }

# 5
# Why does the following code...
# Give us the following error when we run it?

puts "Because there is no ampersand in the method definition."
