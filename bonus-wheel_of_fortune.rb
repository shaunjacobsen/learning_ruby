# This script seeks to emulate the Wheel of Fortune game show

@puzzles = [
    ["Occupation", "Front end developer"],
    ["Person", "The Queen of England"],
    ["Before & After", "A Hole in One Way Ticket"],
    ["Before & After", "Beer Nuts And Bolts"],
    ["Family", "Venus and Serena Williams"],
    ["On the Map", "Auckland New Zealand"],
    ["Food and Drink", "Baked Lasagna"]
]

@wheel = [250, 250, 250, 350, 350, 350, 500, 500, 500, 650, 650, 750, 850, 950, 1000, 1000, "Bankrupt", "Bankrupt", "Lose A Turn"]

score = 0

if score > 0
  @score = @score
else
  @score = 0
end

@num_puzzles = @puzzles.length
@wheel_wedges = @wheel.length

@guessed_letters = []

@num_rounds = 0

def get_puzzle
  rand = Random.new
  rand = rand.rand(0..(@num_puzzles - 1))
  @current_puzzle = @puzzles[rand]
  @current_puzzle_category = @current_puzzle[0]
  @current_puzzle_phrase = @current_puzzle[1].upcase
  @current_puzzle_phrase_parsed = @current_puzzle_phrase.split("")
  @total_letters = @current_puzzle_phrase.to_s.gsub(/\s+/, "").length
  @board = @current_puzzle_phrase_parsed.map { |l| l != " " ? "_" : " " }
end

def show_board
  print "\n\n"
  (@current_puzzle_phrase_parsed.length - (0.5 * @score.to_s.length.to_f)).to_i.times { print " " }
  puts "$#{@score}"
  print "   "
  (@current_puzzle_phrase_parsed.length * 2).times { print "." }
  puts "\n"
  print "•• "
  print @board.join(" ")
  print " "
  puts "••"
  print "   "
  (@current_puzzle_phrase_parsed.length * 2).times { print "." }
  puts "\n\n\n"
end

def spin_wheel
  rand = Random.new
  rand = rand.rand(0..(@wheel_wedges - 1))
  @wheel_selection = @wheel[rand]
  puts "Spinning wheel..."
  wheel_selection
  case @wheel_selection
    when "Lose A Turn"
      puts "Lost a turn, spinning again."
      spin_wheel
    when "Bankrupt"
      puts "Aw, man!"
      @score = 0
      spin_wheel
    else
      return
  end
end

def play
  until @total_letters < 1
    prompt
  end
  puts "Game over! It took you #{@num_rounds} tries to win $#{@score}."
end

def prompt
  puts "What would you like to do: GUESS a letter, BUY a vowel, or SOLVE the puzzle?"
  @answer = gets.chomp.upcase
  case @answer
    when "GUESS"
      select_letter
    when "BUY"
      buy_vowel
    when "SOLVE"
      solve
    else
      "That option isn't available, please try again."
      prompt
  end
end

def add_to_score(amount,multiplier)
  @score += (amount * multiplier).to_i
  show_board
end

def select_letter
  puts "Guess a letter:"
  letter = gets.chomp.upcase
  if letter !~ /[AEIOU]/
    guess_letter(letter)
  else
    puts "Please confirm that you'd like to buy a vowel."
    prompt
  end
end

def buy_vowel
  if @score >= 250
    puts "Enter the letter:"
    vowel = gets.chomp.upcase
    if vowel =~ /[AEIOU]/
      @wheel_selection = 0
      guess_letter(vowel)
      spin_wheel
    else
      puts "Please enter a vowel, not a consonant:"
      buy_vowel
    end
  else
    puts "Sorry, you need at least $250 to buy a vowel."
  end
end

def guess_letter(letter)
  if check_letter(letter)
    letters = @current_puzzle_phrase_parsed.select { |l| letter == l }
    @num_rounds += 1
    puts "\n\n\n\n\n"
    if letters.length == 1
      puts "There is one \"#{letter}\"."
      sleep(1)
      add_letter_to_board(letter,1)
      add_to_score(@wheel_selection,letters.length)
    elsif letters.length > 1
      puts "There are #{letters.length} \"#{letter}\"s."
      sleep(1)
      add_letter_to_board(letter,letters.length)
      add_to_score(@wheel_selection,letters.length)
    else
      puts "There are no \"#{letter}\"s."
    end
    sleep(1)
  else
    puts "You have already guessed that letter."
    select_letter
  end
end

def solve
  puts "Alright, type out your guess:"
  string = gets.chomp.upcase
  if string.upcase == @current_puzzle_phrase
    @board = @current_puzzle_phrase_parsed
    show_board
    @total_letters = 0
  else
    puts "Nope, that's not right. Spinning..."
    spin_wheel
  end
end

def add_letter_to_board(letter,num_letters)
  num_letters.times do
    index = @current_puzzle_phrase_parsed.find_index(letter)
    @board[index] = letter
    @current_puzzle_phrase_parsed[index] = ""
  end
  @guessed_letters << letter
  @total_letters -= num_letters
end

# if the letter is in the @guessed_letters array, return FALSE to reject
def check_letter(letter)
  @guessed_letters.include?(letter) ? false : true
end

def wheel_selection
  if @wheel_selection.is_a?(Fixnum)
    puts "$#{@wheel_selection}"
  else
    puts "#{@wheel_selection}"
  end
end

puts "Let's play!"
get_puzzle
puts "The category is " + @current_puzzle_category
show_board
spin_wheel
play