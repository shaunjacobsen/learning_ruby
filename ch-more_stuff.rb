# Intro to Programming
# More Stuff
# Exercise Answers

# Exercise 1
# Write a program that checks if the sequence of characters
# "lab" exists in the following strings. If it does exist,
# print out the word. - "laboratory" - "experiment" - "Pans Labyrinth" - "elaborate" - "polar bear"

def contains?(word)
	if word.length > 0
		if /lab/ =~ word
			puts "#{word} contains the string 'lab'"
		else
			puts "Not in that word."
		end
		else
			puts "Please specify a word."
	end
end

contains?("laboratory")
contains?("experiment")
contains?("Pans Labyrinth")
contains?("elaborate")
contains?("polar bear")
contains?("")
