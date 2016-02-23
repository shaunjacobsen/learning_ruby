# 1
phrase = "The Flintstones Rock!"
10.times { |n| puts ((" " * n) + phrase) }

# 2
statement = "The Flintstones Rock"
letter_frequency = {}
statement.chars.each do |x|
  if letter_frequency.has_key?(x)
    letter_frequency[x] += 1
  else
    letter_frequency[x] = 1
  end
end
puts letter_frequency

# 3
# You're trying to concatenate a String with an Integer.
puts "the value of 40 + 2 is " + (40 + 2).to_s
puts "the value of 40 + 2 is #{(40 + 2)}"

# 4
# It will skip over every other element of the array
# First one: 1, 3
# Second one: 1, 2

# 5
