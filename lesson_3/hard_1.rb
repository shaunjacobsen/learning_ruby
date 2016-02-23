# 1
# => nil

# 2
# => hi there

# 3
# A will return one = one, two = two, three = three
# B will return one = one, two = two, three = three
# C will return one = two, two = three, three = one

# 4
# There's already a ruby way to do this:
require 'SecureRandom'
puts SecureRandom.uuid

# 5
def dot_separated_ip_address?(input_string)
  dot_separated_words = input_string.split(".")
  while dot_separated_words.size > 0 do
    word = dot_separated_words.pop
    break if !is_a_number?(word)
  end
  return true
end

def ip_address?(input_string)
  if input_string =~ /\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}/
    return true
  else
    return false
  end
end

puts ip_address?("10.1.0.1")
puts ip_address?("10.No.90.544")
puts ip_address?("50.233.26.214")