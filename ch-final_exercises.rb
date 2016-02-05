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

# 5
# Get rid of "11". And append a "3".

a.pop
a << 3

puts "---\n#5\n---"
puts a

# 6
# Get rid of duplicates without specifically removing any one value.

a.uniq!

puts "---\n#6\n---"
puts a

# 7
# What's the major difference between an Array and a Hash?

puts "---\n#7\n---"
puts "A hash contains key-value pairs."

# 8
# Create a Hash using both Ruby syntax styles.

this_hash = Hash.new
that_hash = {}

# 9
# Suppose you have a hash h = {a:1, b:2, c:3, d:4}

puts "---\n#9\n---"
h = {a:1, b:2, c:3, d:4}
puts h[:b]
h[:e] = 5
puts h
h.select! { |n,v| v >= 3.5 }
puts h

# 10
# Can hash values be arrays? Can you have an array of hashes? (give examples)

puts "---\n#10\n---"
puts "Yes, see examples:"
q = {languages:["English","French","Portuguese"],homeland:"France"}
puts q
r = [1, "Hello", {artist:"Adele",album:"25"}, "Locksmith"]
puts r
puts r[2][:album] # should print 25

# 11
# Look at several Rails/Ruby online API sources and say which one you like best and why.

puts "---\n#11\n---"
puts "I found this url, http://api.rubyonrails.org, which seems to have a lot of information on what is available in Rails with Ruby."

# 12
# Given the following data structures. Write a program that moves the information from the array into the empty hash that applies to the correct person.

contact_data = [["joe@email.com", "123 Main st.", "555-123-4567"],
               ["sally@email.com", "404 Not Found Dr.", "123-234-3454"]]
               
contacts = {"Joe Smith" => {}, "Sally Johnson" => {}}

contacts["Joe Smith"][:email] = contact_data[0][0]
contacts["Joe Smith"][:address] = contact_data[0][1]
contacts["Joe Smith"][:phone] = contact_data[0][2]
contacts["Sally Johnson"][:email] = contact_data[1][0]
contacts["Sally Johnson"][:address] = contact_data[1][1]
contacts["Sally Johnson"][:phone] = contact_data[1][2]

# 13
# Using the hash you created from the previous exercise, demonstrate how you would access Joe's email and Sally's phone number?

puts "---\n#13\n---"
puts contacts["Joe Smith"][:email]
puts contacts["Sally Johnson"][:phone]

# 14
# In exercise 12, we manually set the contacts hash values one by one. Now, programmatically loop or iterate over the contacts hash from exercise 12, and populate the associated data from the contact_data array. Hint: you will probably need to iterate over ([:email, :address, :phone]), and some helpful methods might be the Array shift and first methods.

contact_data = ["joe@email.com", "123 Main st.", "555-123-4567"]
contact_fields = [:email, :address, :phone]
contacts = {"Joe Smith" => {}}

contact_data.each do |x|
	contacts["Joe Smith"][:"#{contact_fields.shift}"] = x
end

puts "---\n#14\n---"
puts contacts
puts "Joe's address is #{contacts["Joe Smith"][:address]}"
puts "But he prefers to be reached at #{contacts["Joe Smith"][:email]}."

# 15
# Use Ruby's Array method delete_if and String method start_with? to delete all of the words that begin with an "s" in the following array.

arr = ['snow', 'winter', 'ice', 'slippery', 'salted roads', 'white trees']

puts "---\n#15\n---"
p arr

arr.delete_if { |x| x.start_with?('s') }

puts "Deleting all elements starting with 's'"
p arr

arr = ['snow', 'winter', 'ice', 'slippery', 'salted roads', 'white trees']

arr.delete_if { |x| x.start_with?('s') || x.start_with?('w') }

puts "Deleting all elements starting with 's' or 'w'"
p arr

# 16
# Take the following array and turn it into a new array that consists of strings containing one word. (ex. ["white snow", etc...] → ["white", "snow", etc...]. Look into using Array's map and flatten methods, as well as String's split method.

a = ['white snow', 'winter wonderland', 'melting ice', 'slippery sidewalk', 'salted roads', 'white trees']
b = []

a.each do |x|
	if x.split(" ").length > 1
		split_up = []
		b << split_up << x.split(" ")
	else
		b << x
	end
end

b.flatten!

puts "---\n#16\n---"
p b

# 17
# What will the following program output?

puts "---\n#17\n---"
puts "These hashes are the same!"
