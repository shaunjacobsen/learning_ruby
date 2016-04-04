require 'pry'

class Board
  INITIAL_MARKER = ' '
  def initialize
    @squares = {}
    (1..9).each { |key| @squares[key] = Square.new(INITIAL_MARKER) }
  end

  def get_square_at(key)
    @squares[key] # returns a 'square' object
  end

  def set_square_at(key, marker)
    @squares[key].marker = marker
  end
end

class Square
  attr_accessor :marker

  def initialize(marker)
    @marker = marker
  end

  def to_s
    @marker
  end
end

class Player
  attr_reader :marker

  def initialize(marker)
    @marker = marker
  end
end

class TTTGame
  HUMAN_MARKER = "X"
  COMPUTER_MARKER = "O"
  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new # represents the state of the board at any given time
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
  end

  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
    puts ""
  end

  def display_goodbye_message
    puts "Thanks for playing!"
  end

  def display_board
    puts ""
    puts "     |     |"
    puts "  #{board.get_square_at(1)}  |  #{board.get_square_at(2)}  |  #{board.get_square_at(3)}"
    puts "     |     |"
    puts "-----|-----|-----"
    puts "     |     |"
    puts "  #{board.get_square_at(4)}  |  #{board.get_square_at(5)}  |  #{board.get_square_at(6)}"
    puts "     |     |"
    puts "-----|-----|-----"
    puts "     |     |"
    puts "  #{board.get_square_at(7)}  |  #{board.get_square_at(8)}  |  #{board.get_square_at(9)}"
    puts "     |     |"
    puts ""
  end

  def human_moves
    square = nil
    puts "Choose a square between 1-9:"
    loop do
      square = gets.chomp.to_i
      break if (1..9).include?(square)
      puts "Sorry, not a valid choice. Try again:"
    end

    def computer_moves
      board.set_square_at((1..9).to_a.sample, computer.marker)
    end

    binding.pry

    board.set_square_at(square, human.marker)
  end

  def play
    display_welcome_message
    loop do
      display_board
      human_moves
      display_board
      #break if someone_won? || board_full?
      
      computer_moves
      display_board
      #break if someone_won? || board_full?
      break
    end

    display_result
    display_goodbye_message
  end
end

game = TTTGame.new
game.play