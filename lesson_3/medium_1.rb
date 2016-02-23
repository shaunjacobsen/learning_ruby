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
def factors(number)
  dividend = number
  divisors = []
  loop do
    if dividend > 0
      divisors << number / dividend if number % dividend == 0
      dividend -= 1
    elsif dividend <= 0
      break
    end
  end
  divisors
end

p factors(0)
p factors(144)

# 6
# The first method mutates the original array, whereas the second ones doesn't

# 7
def fib(first_num, second_num)
  limit = 15
  while second_num < limit
    sum = first_num + second_num
    first_num = second_num
    second_num = sum
  end
  sum
end

result = fib(3, 2)
p result

# 8
def titleize(phrase)
  phrase.split.map { |w| w.capitalize }.join(" ")
end

puts titleize("The dog jumps over the log")

# 9
munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

munsters.each do |k,v|
  age_classification = case when munsters[k]["age"].between?(0, 18)
    age_classification = "kid"
  when munsters[k]["age"].between?(18, 64)
    age_classification = "adult"
  when munsters[k]["age"] > 64
    age_classification = "senior"
  else
    age_classification = "unknown"
  end
  munsters[k]["age_group"] = age_classification
end

p munsters