require 'pry'

class Card
  attr_accessor :suit, :face

  SUITS = %w(Hearts Clubs Spades Diamonds).freeze
  FACES = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', 'King', 'Ace'].freeze

  def initialize(suit, face)
    @suit = suit
    @face = face
  end

  def value
    case @face
    when /[2-9]/
      @face.to_i
    when '10', 'Jack', 'Queen', 'King'
      10
    when 'Ace'
      0
    end
  end

  def to_s
    "#{@face} of #{@suit}"
  end
end

class Deck
  attr_accessor :cards

  def initialize
    @cards = []
    Card::SUITS.each do |suit|
      Card::FACES.each do |face|
        @cards << Card.new(suit, face)
      end
    end
    rearrange
  end

  def rearrange
    cards.shuffle!
  end

  def deal
    cards.pop
  end
end

module Hand
  def total_value
    card_values = []
    cards.reverse_each do |card|
      card_values << card.value
    end
    hand_total = card_values.inject(:+)
    aces = card_values.select { |value| value == 0 }
    ace_value = 0
    aces.each do
      if hand_total + 10 < 21
        ace_value = 11
      else
        ace_value = 1
      end
      ace_to_rewrite = card_values.index(0)
      card_values[ace_to_rewrite] = ace_value
    end
    card_values.inject(:+)
  end
end

class Player
  include Hand

  attr_accessor :cards

  def initialize
    @cards = []
  end

  def bust?
    total_value > 21
  end

  def show_cards
    cards.map(&:to_s).join(', ')
  end

  def give_card(deck)
    cards << deck
  end
end

class Human < Player
end

class Dealer < Player
  def show_cards
    hand = [cards[0]]
    cards_to_hide = cards.drop(1)
    cards_to_hide.each do
      hand << "unknown"
    end
    hand.join(', ')
  end
end

class TwentyOne
  attr_accessor :deck, :human, :dealer, :turns

  def initialize
    @deck = Deck.new
    @human = Human.new
    @dealer = Dealer.new
    @turns = []
  end

  def start
    loop do
      system 'clear'
      deal_cards
      loop do
        break if end?
        player_turn
        break if human.bust?
        puts "Dealer's turn..."
        dealer_turn
        puts ""
      end
      show_result
      break if !play_again?
    end
  end

  def end?
    two_stays? || human.bust? || dealer.bust? || winner?
  end

  def play_again?
    puts "Do you want to play again? y or n:"
    answer = ''
    loop do
      answer = gets.chomp.downcase
      break if %w(y n).include? answer
      "Incorrect input. Type 'y' if you want to play again, 'n' if not:"
    end
    if answer.start_with?('y')
      reset
      return true
    end
    false
  end

  def reset
    self.deck = Deck.new
    self.human = Human.new
    self.dealer = Dealer.new
  end

  def deal_cards
    [human, dealer].each do |participant|
      2.times do |_|
        participant.cards << deck.deal
      end
    end
  end

  def hit(participant)
    puts "Hitting this round"
    participant.give_card(deck.deal)
    add_turn(participant, 'hit')
  end

  def stay(participant)
    puts "Staying this round"
    add_turn(participant, 'stay')
  end

  def two_stays?
    if turns.length > 1
      turns[0][1] == 'stay' && turns[1][1] == 'stay'
    else
      false
    end
  end

  def add_turn(participant, turn)
    turns.shift if turns.size > 1
    turns << [participant, turn]
  end

  def show_cards
    puts "Cards in your hand: #{human.show_cards} (#{human.total_value})"
  end

  def player_turn
    show_cards
    puts "Hit (h) or Stay (s)?"
    answer = ''
    loop do
      answer = gets.chomp.downcase
      break if %w(h s).include? answer
      puts "No, choose hit or stay:"
    end
    hit(human) if answer.start_with?('h')
    stay(human) if answer.start_with?('s')
  end

  def dealer_turn
    if dealer.total_value < 17
      hit(dealer)
      puts "Dealer's hand: #{dealer.show_cards}."
    else
      stay(dealer)
    end
  end

  def winner?
    human.total_value == 21 || dealer.total_value == 21
  end

  def who_won
    case
    when (human.total_value > dealer.total_value) && human.total_value <= 21
      "Human won!"
    when (human.total_value > dealer.total_value) && human.total_value > 21
      "Dealer won!"
    when (dealer.total_value > human.total_value) && dealer.total_value <= 21
      "Dealer won!"
    when (dealer.total_value > human.total_value) && dealer.total_value > 21
      "Human won!"
    else
      "It's a tie."
    end
  end

  def show_result
    puts "Game over!"
    puts "Your hand: #{human.show_cards}"
    puts "Dealer's hand: #{dealer.show_cards}."
    puts "You: #{human.total_value} / Dealer: #{dealer.total_value}"
    puts who_won
  end
end

game = TwentyOne.new
game.start
