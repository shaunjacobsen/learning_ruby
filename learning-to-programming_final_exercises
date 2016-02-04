# 1
# Use the each method of Array to iterate over [1, 2, 3, 4, 5, 6, 7, 8, 9, 10], and print out each value.

a = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

puts "---\n#1\n---"

a.each { |number| puts number }

# 2
# Same as above, but only print out values greater than 5.

puts "---\n#2\n---"

a.each do |number|
  if number > 5
    puts number
  end
end

# 3
# Now, using the same array from #2, use the select method to extract all odd numbers into a new array.

a_even = []

a.select do |number|
  if number.even?
    a_even << number
  end
end

puts "---\n#3\n---"
puts a_even

# 4
# Append "11" to the end of the original array. Prepend "0" to the beginning.

a << 11
a.unshift(0)

puts "---\n#4\n---"
puts a
