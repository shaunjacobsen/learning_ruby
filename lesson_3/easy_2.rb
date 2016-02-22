# 1
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }
puts ages.has_key?("Spot")

# 2
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }
puts ages.values.inject(:+)

# 3
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }
puts ages.delete_if { |k, v| v > 100 }

# 4
munsters_description = "The Munsters are creepy in a good way."
puts munsters_description.capitalize
puts munsters_description.swapcase
puts munsters_description.downcase
puts munsters_description.upcase

# 5
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10 }
additional_ages = { "Marilyn" => 22, "Spot" => 237 }
puts ages.merge!(additional_ages)

# 6
puts ages.values.min

# 7
advice = "Few things in life are as important as house training your pet dinosaur."
puts advice.include?("dino")

# 8
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
puts flintstones.index { |x| x.start_with?("Be") }

# 9
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
puts flintstones.map { |x| x[0, 3] }

# 10
# I have already been doing one-line blocks where feasible, see #9.
