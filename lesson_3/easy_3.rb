# 1
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

# 2
flintstones << "Dino"

# 3
flintstones.push("Dino").push("Hoppy")

# 4
advice = "Few things in life are as important as house training your pet dinosaur."
puts advice.slice!(39..advice.length)
puts advice

# 5
statement = "The Flintstones Rock!"
puts statement.count("t")

# 6
title = "Flintstone Family Members"
puts title.length / 2
puts title.center(40)