require 'pry'

INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
POINTS_TO_END = 5 # the directions said not to use constants, but I feel like this is OK

WINNING_LINES = [[1,2,3],[4,5,6],[7,8,9]] + # rows
                [[2,5,8],[1,4,7],[3,6,9]] + # columns
                [[1,5,9],[3,5,7]]           # diagonals

score = { "player" => 0, "computer" => 0 }

def prompt(msg)
  puts "=> #{msg}"
end

def joinor(arr,delimeter=', ',word='or ')
  if arr.length > 2
    last_element = arr.pop.to_s
    first_elements = arr.join(delimeter)
    first_elements + delimeter + word + last_element
  elsif arr.length == 2
    arr[0].to_s + ' ' + word + arr[1].to_s
  else
    arr.to_s
  end
end

def display_board(brd)
  system 'clear'
  puts "You're #{PLAYER_MARKER}. Computer is #{COMPUTER_MARKER}"
  puts ""
  puts "     |     |"
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts "     |     |"
  puts ""
end

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def player_places_piece!(brd)
  square = ''
  loop do
    prompt "Choose a square (#{joinor(empty_squares(brd))}):"
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt "Sorry, that's not a valid choice (#{empty_squares(brd).join(', ')}):"
  end

  brd[square] = PLAYER_MARKER
end

def computer_places_piece!(brd)
  square = nil

  WINNING_LINES.each do |line|
    square = detect_threat(brd, line)
    break if square
  end

  if !square
    square = empty_squares(brd).sample
  end

  brd[square] = COMPUTER_MARKER
end

def detect_threat(brd, line)
  if brd.values_at(*line).count(PLAYER_MARKER) == 2
    brd.select { |k,v| line.include?(k) && v == INITIAL_MARKER }.keys.first
  else
    nil
  end
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd) # !! turns the value into a boolean
end

def increment_score(recipient, value, score_hash)
  score_hash[recipient] += value
end

def display_score(score_hash)
  score = score_hash
  player_score = score["player"]
  computer_score = score["computer"]
  prompt "Player #{player_score} || Computer #{computer_score}"
end

def end_game?(score_hash, points)
  score_hash["player"] == points || score_hash["computer"] == points
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(line[0], line[1], line[2]).count(PLAYER_MARKER) == 3
      return 'Player'
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3 # '*line' is the same as iterating over the array
      return 'Computer'
    end
  end
  nil
end

loop do
  board = initialize_board

  loop do
    display_board(board)

    player_places_piece!(board)
    if someone_won?(board) || board_full?(board)
      increment_score("player", 1, score)
      break
    end

    computer_places_piece!(board)
    if someone_won?(board) || board_full?(board)
      increment_score("computer", 1, score)
      break
    end
  end

  if someone_won?(board)
    prompt "#{detect_winner(board)} won!"
    display_score(score)
  else
    prompt "It's a tie."
  end

  break if end_game?(score, POINTS_TO_END)

  prompt "Let's try to make it to #{POINTS_TO_END}. Wanna keep going? (y or n)"
  answer = gets.chomp

  break if answer.start_with?('n')
end

prompt "Thanks for playing Tic-Tac-Toe!"