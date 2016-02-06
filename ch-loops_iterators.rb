# 1
# What does the each method in the following program return after it is finished executing?

puts "---\n#1\n---"
puts "[1, 2, 3, 4, 5]"

# 2
# Write a while loop that takes input from the user, performs an action, and only stops when the user types "STOP". Each loop can get info from the user.

puts "---\n#2\n---"
puts "Write something:"
input = gets.chomp.upcase

while input != "STOP"
  puts "Write something again:"
  input = gets.chomp.upcase
end

# 3
# Use the each_with_index method to iterate through an array of your creation that prints each index and value of the array.

a = [1, 3, "Legos", 17.6]

puts "---\n#3\n---"
a.each_with_index { |x,y| puts "#{y}. #{x}"}

# 4
# Write a method that counts down to zero using recursion.

def countdown(num)
  if num <= 0
    puts num
  else
    puts num
    countdown(num-1)
  end
end

puts "---\n#4\n---"
countdown(10)