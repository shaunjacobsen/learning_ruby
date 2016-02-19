# This script seeks to emulate the Wheel of Fortune game show

@puzzles = [
    ["Occupation", "Front end developer"],
    ["Person", "The Queen of England"],
    ["Before & After", "A Hole in One Way Ticket"],
    ["Before & After", "Beer Nuts And Bolts"],
    ["Family", "Venus and Serena Williams"],
    ["On the Map", "Auckland New Zealand"],
    ["Food and Drink", "Baked Lasagna"],
    ["Landmark", "Empire State Building"],
    ["Landmark", "Grand Central Station"],
    ["Landmark", "Niagara Falls"],
    ["Fictional Character", "Clark Kent"],
    ["What are you doing?", "Getting a haircut"],
    ["What are you doing?", "Flying a kite"],
    ["Thing", "Bag of groceries"],
    ["Thing", "Cinnamon flavored breath mints"],
    ["Thing", "Frequently asked questions"],
    ["Place", "Northerly Island"],
    ["Place", "Lincoln Park Zoo"],
    ["Street", "Broadway"],
    ["Person", "Experienced Traveler"]
]

@wheel = [250, 250, 250, 350, 350, 350, 500, 500, 500, 650, 650, 750, 850, 950, 1000, 1000, 2500, 5000, "Bankrupt", "Bankrupt", "Lose A Turn"]

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

def reset
  @num_rounds = 0
  @guessed_letters = []
end


def show_board
  sleep(0.5)
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
  print "Spinning wheel"
  5.times do
    sleep(0.3)
    print "."
  end
  print "\n\n"
  wheel_selection
  print "\n\n"
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
  puts "What would you like to do: GUESS a letter, BUY a vowel, or SOLVE the puzzle? (You can also SEE letters you've used or QUIT)"
  @answer = gets.chomp.upcase
  case @answer
    when "GUESS"
      select_letter
    when "BUY"
      buy_vowel
    when "SOLVE"
      solve
    when "SEE"
      see
    when "QUIT"
      exit
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
      @score -= 250
      spin_wheel
    else
      puts "Please enter a vowel, not a consonant."
      buy_vowel
    end
  else
    puts "Sorry, you need at least $250 to buy a vowel."
  end
end

def guess_letter(letter)
  if check_letter(letter)
    @guessed_letters << letter
    letters = @current_puzzle_phrase_parsed.select { |l| letter == l }
    @num_rounds += 1
    5.times do
      sleep(0.2)
      puts ".\n"
    end
    if letters.length == 1
      puts "There is one \"#{letter}\"."
      add_letter_to_board(letter,1)
      add_to_score(@wheel_selection,letters.length)
      spin_wheel
    elsif letters.length > 1
      puts "There are #{letters.length} \"#{letter}\"s."
      add_letter_to_board(letter,letters.length)
      add_to_score(@wheel_selection,letters.length)
      spin_wheel
    else
      puts "There are no \"#{letter}\"s."
      spin_wheel
    end
    sleep(0.2)
  else
    puts "Invalid input, please try again."
    select_letter
  end
end

def solve
  puts "Alright, type out your guess:"
  string = gets.chomp.upcase
  if string.upcase == @current_puzzle_phrase
    @board = @current_puzzle_phrase.split("")
    show_board
    @total_letters = 0
  else
    puts "Nope, that's not right. Spinning..."
    spin_wheel
  end
end

def add_letter_to_board(letter,num_letters)
  num_letters.times do
    show_board
    sleep(0.5)
    index = @current_puzzle_phrase_parsed.find_index(letter)
    @board[index] = letter
    @current_puzzle_phrase_parsed[index] = ""
  end
  @total_letters -= num_letters
end

# if the letter is in the @guessed_letters array, return FALSE to reject
def check_letter(letter)
  if letter.length == 1
    @guessed_letters.include?(letter) ? false : true
  else
    false
  end
end

def wheel_selection
  if @wheel_selection.is_a?(Fixnum)
    puts "$#{@wheel_selection}"
  else
    puts "#{@wheel_selection}"
  end
end

def see
  puts "You've used the following letters:"
  if @guessed_letters.length > 1
    @guessed_letters.each { |a| print "#{a}, " }
  elsif @guessed_letters.length == 1
    @guessed_letters.each { |a| print "#{a}" }
  else
    print "None so far."
  end
  print "\n\n"
end

def quit
  i = 0
end

puts "WHEEL OF FORTUNE"
puts "press control + C at any time to exit"

i = 1

while i == 1 do
  sleep(1)
  puts "Let's play!"
  sleep(1)
  get_puzzle
  puts "The category is " + @current_puzzle_category
  sleep(1)
  show_board
  spin_wheel
  play
  reset
end
