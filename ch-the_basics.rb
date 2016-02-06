# 1
# Add two strings together that, when concatenated, return your first and last name as your full name in one string.

puts "---\n#1\n---"
puts "Shaun" + " Jacobsen"

# 2
# Use the modulo operator, division, or a combination of both to take a 4 digit number and find 1) the thousands number 2) the hundreds 3) the tens and 4) and the ones.

thousands = 1468 / 1000
hundreds = 1468 % 1000 / 100
tens = 1468 % 1000 % 100 / 10
ones = 1468 % 1000 % 100 % 10

puts "---\n#2\n---"
puts thousands
puts hundreds
puts tens
puts ones

# 3
# Write a program that uses a hash to store a list of movie titles with the year they came out. Then use the puts command to make your program print out the year of each movie to the screen. The output for your program should look something like this.

movies = {
    "Mean Girls": 2004,
    "Elf": 2003,
    "Forrest Gump": 1994,
    "The Godfather": 1972
}

puts "---\n#3\n---"
movies.each { |k,v| puts v }

# 4
# Use the dates from the previous example and store them in an array. Then make your program output the same thing as exercise 3.

dates = [2004,2003,1994,1972]

puts "---\n#4\n---"
dates.each { |y| puts y }

# 5
# Write a program that outputs the factorial of the numbers 5, 6, 7, and 8.

puts "---\n#5\n---"
puts 5 * 4 * 3 * 2 * 1
puts 6 * 5 * 4 * 3 * 2 * 1
puts 7 * 6 * 5 * 4 * 3 * 2 * 1
puts 8 * 7 * 6 * 5 * 4 * 3 * 2 * 1

# 6
# Write a program that calculates the squares of 3 float numbers of your choosing and outputs the result to the screen.

puts "---\n#6\n---"
puts 3.74 ** 3.74
puts 1.03 ** 1.03
puts 10.84 ** 10.84

# 7
# What does the following error message tell you?

puts "There was a parentheses instead of a bracket in the code, likely where an inline block or hash should have ended"