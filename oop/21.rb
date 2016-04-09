require 'pry'

class Card
  SUITS = %w(Hearts Clubs Spades Diamonds)
  FACES = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', 'King', 'Ace']

  def initialize(suit, face)
    @suit = suit
    @face = face
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

class Player
  attr_accessor :cards

  def initialize
    @cards = []
  end

end

class Human < Player

end

class Dealer < Player

end

module Hand

end

class TwentyOne
  attr_accessor :deck, :human, :dealer

  def initialize
    @deck = Deck.new
    @human = Human.new
    @dealer = Dealer.new
  end

  def start
    deal_cards
    show_initial_cards
    player_turn
    dealer_turn
    show_result
  end

  def deal_cards
    [human, dealer].each do |participant|
      2.times do |_|
        participant.cards << deck.deal
      end
    end
    p human.cards
    p dealer.cards
  end

  def show_initial_cards
  end

  def player_turn
  end

  def dealer_turn
  end

  def show_result
  end


end

game = TwentyOne.new
game.start