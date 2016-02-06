# 1
# Given a hash of family members, with keys as the title and an array of names as the values, use Ruby's built-in select method to gather only immediate family members' names into a new array.

family = {  uncles: ["bob", "joe", "steve"],
            sisters: ["jane", "jill", "beth"],
            brothers: ["frank","rob","david"],
            aunts: ["mary","sally","susan"]
}

immediate_family = family.select { |k,v| k == :brothers || k == :sisters }

puts "---\n#1\n---"
puts immediate_family.values.flatten

# 2
# Look at Ruby's merge method. Notice that it has two versions. What is the difference between merge and merge!? Write a program that uses both and illustrate the differences.

hash1 = {name: "Shaun", gender: "Male"}
hash2 = {age: 25, city: "Chicago"}

puts "---\n#2\n---"
puts "Original hash:"
puts hash1
puts "Second hash:"
puts hash2
puts "Temporarily merged hash:"
puts hash1.merge(hash2)
puts "Original hash is unmodified, though:"
puts hash1
puts "Unless I use hash1.merge!(hash2)"
puts hash1.merge!(hash2)
puts "Then, hash1 is permanently modified:"
puts hash1

# 3
# Using some of Ruby's built-in Hash methods, write a program that loops through a hash and prints all of the keys. Then write a program that does the same thing except printing the values. Finally, write a program that prints both.

puts "---\n#3\n---"
puts "Keys:"
hash1.each_key { |k| puts k }
puts "Values:"
hash1.each_value { |v| puts v }
puts "All together now:"
hash1.each {|k,v| puts "#{k}: #{v}" }

# 4
# Given the following expression, how would you access the name of the person?

person = {name: 'Bob', occupation: 'web developer', hobbies: 'painting'}

puts "---\n#4\n---"
puts person[:name]

# 5
# What method could you use to find out if a Hash contains a specific value in it? Write a program to demonstrate this use.

def has_value?(hash,val)
  the_hash = hash
  if the_hash.value?(val)
    puts "#{val} is in the hash."
  else
    puts "#{val} is not in the hash."
  end
end

puts "---\n#5\n---"
has_value?(hash1,26)
has_value?(hash1,"Chicago")

# 6
# Write a program that prints out groups of words that are anagrams. Anagrams are words that have the same exact letters in them but in a different order.

words =  ['demo', 'none', 'tied', 'evil', 'dome', 'mode', 'live',
          'fowl', 'veil', 'wolf', 'diet', 'vile', 'edit', 'tide',
          'flow', 'neon']

anagrams = {}

words.each do |w|
  key = w.split("").sort.join
  if anagrams.has_key?(key)
    anagrams[key].push(w)
  else
    anagrams[key] = [w]
  end
end

puts "---\n#6\n---"
anagrams.each do |k,v|
  puts "....."
  puts v
end

# 7
# What's the difference between the two hashes that were created?

x = "hi there"
my_hash = {x: "some value"}
my_hash2 = {x => "some value"}

puts "---\n#7\n---"
puts "The first hash created used x as a symbol."

# 8
# If you see this error, what do you suspect is the most likely problem?

puts "---\n#8\n---"
puts "B. There is no method called keys for Array objects."
