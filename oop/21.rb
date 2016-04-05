require 'pry'

class Hand
  def initialize
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
    deck.shuffle.pop
  end

end

class Card

end

class Game
  def start
    #deal_cards
    #show_initial_cards
    #player_turn
    #dealer_turn
    #show_result
  end
end

Game.new.start
game_deck = Deck.new
p game_deck
puts "---"
p game_deck.deal
p game_deck