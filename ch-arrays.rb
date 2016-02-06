# 1
# Below we have given you an array and a number. Write a program that checks to see if the number appears in the array.

arr = [1, 3, 5, 7, 9, 11]
number = 3

puts "---\n#1\n---"
puts arr.include?(number)

# 2
# What will the following programs return? What is value of arr after each?

puts "---\n#2\n---"
puts "1. [[\"b\"], [\"b\", 2], [\"b\", 3], [\"a\", 1], [\"a\", 2], [\"a\", 3]]"
puts "2. [[\"b\"], [\"a\", [1, 2, 3]]]"

# 3
# How do you print the word "example" from the following array?

arr = [["test", "hello", "world"],["example", "mem"]]

puts "---\n#3\n---"
puts arr[1][0]

# 4
# What does each method return in the following example?

arr = [15, 7, 18, 5, 12, 8, 5, 1]

puts "---\n#4\n---"
puts "1. 3"
puts "2. nil"
puts "3. 8"

# 5
# What is the value of a, b, and c in the following program?

puts "---\n#5\n---"
puts "1. e"
puts "2. A"
puts "3. nil"

# 6
# What is the problem and how can it be fixed?

puts "---\n#6\n---"
puts "You can't set the value of an array using its value, you need the index number or a method"

# 7
# Write a program that iterates over an array and builds a new array that is the result of incrementing each value in the original array by a value of 2. You should have two arrays at the end of this program, The original array and the new array you've created. Print both arrays to the screen using the p method instead of puts.

arr1 = [1, 5, 9, 15]
arr2 = []

arr1.each do |x|
  arr2 << x + 2
end

puts "---\n#7\n---"
p arr1
p arr2