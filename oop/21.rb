require 'pry'

class Hand
  attr_accessor :hand_array
  def initialize
    2.times do
      @hand_array << @game_deck.deal
    end
  end

  def show
  end

end

class Deck
  attr_accessor :deck

  CARDS = [["2", 2], ["3", 3], ["4", 4], ["5", 5], ["6", 6], ["7", 7], ["8", 8], ["9", 9], ["10", 10]] +
          [["Jack", 10], ["Queen", 10], ["King", 10], ["Ace", 0]]

  def initialize
    @deck = []
    suits = %w(Hearts Spades Clubs Diamonds)
    suits.each do |suit|
      CARDS.each do |card|
        deck << [suit, card].flatten
      end
    end
  end

  def deal
    deck.shuffle!.pop
  end

end

class Card

end

class Player
  attr_accessor :player_type, :player_hand

  def initialize(player_type)
    @player_type = player_type
    @player_hand = Hand.new
  end
end

class Game
  attr_accessor :game_deck

  def initialize
    @game_deck = Deck.new
    @human = Player.new('human')
    @dealer = Player.new('dealer')
  end

  def start
    
    
    #show_initial_cards
    #player_turn
    #dealer_turn
    #show_result
  end
end

Game.new.start