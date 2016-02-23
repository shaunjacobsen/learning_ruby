# 1
munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" }
}

ages = 0
munsters.each do |k, v|
  ages += v["age"] if v["gender"] == 'male'
end

# 2
munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

munsters.each do |name, info|
  age = info["age"]
  gender = info["gender"]
  puts "#{name} is a #{age} year old #{gender}."
end

# 3
def not_a_tricky_method(a_string_param, an_array_param)
  a_string_param += "rutabaga"
  an_array_param << "rutabaga"
end

my_string = "pumpkins"
my_array = ["pumpkins"]
my_string, my_array = not_a_tricky_method(my_string, my_array)

puts "My string looks like this now: #{my_string}"
puts "My array looks like this now: #{my_array}"

# 4
sentence = "Humpty Dumpty sat on a wall."

puts sentence.gsub(/\./, "").split(" ").reverse.join(" ") + "."

# 5
# => 34

# 6
# => The original hash will be manipulated, since a copy of the munsters hash wasn't created

# 7
# => paper

#8 
# => no


