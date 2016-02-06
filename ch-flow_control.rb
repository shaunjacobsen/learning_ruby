# 1
# Write down whether the following expressions return true or false. Then type the expressions into irb to see the results.

puts "---\n#1\n---"
puts "1. false"
puts "2. false"
puts "3. false"
puts "4. true"
puts "5. true"

# 2
# Write a method that takes a string as argument. The method should return the all-caps version of the string, only if the string is longer than 10 characters.

def capitalize(str)
  return str.upcase
end

puts "---\n#2\n---"
puts capitalize("hello world")

# 3
# Write a program that takes a number from the user between 0 and 100 and reports back whether the number is between 0 and 50, 51 and 100, or above 100.

puts "---\n#3\n---"
puts "Give me a number between 0 and 100:"
number = gets.chomp.to_i

if number < 0
  puts "No negatives."
elsif number <= 50
  puts "#{number} is between 0 and 50."
elsif number <= 100
  puts "#{number} is between 51 and 100."
else
  puts "#{number} is above 100."
end

# 4
# What will each block of code below print to the screen? Write your answer on a piece of paper or in a text editor and then run each block of code to see if you were correct.

puts "---\n#4\n---"
puts "1. False"
puts "2. Did you get it right?"
puts "3. Alright now!"

# 5
# Rewrite your program from exercise 3 using a case statement. Wrap each statement in a method and make sure they both still work.

def eval(num)
  case
    when num < 0
      puts "No negatives."
    when num <= 50
      puts "#{num} is between 0 and 50."
    when num <= 100
      puts "#{num} is between 51 and 100."
    else
      puts "#{num} is above 100."
  end
end

puts "---\n#5\n---"
puts "Give me a number between 0 and 100:"
number = gets.chomp.to_i

eval(number)

# 6
# Why do you get this error and how can you fix it?

puts "---\n#6\n---"
puts "The method was never closed with 'end'."