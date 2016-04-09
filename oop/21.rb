require 'pry'

class Cards
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
    Card::SUITS.each do |card|
      CARD::FACES.each do |face|
        @cards << Card.new(suit, face)
      end
    end
    rearrange
  end

  def rearrange
    cards.shuffle!
  end

  def deal(quantity)
    quantity.times do |_|
      cards.pop
    end
  end

end

class Player

end

class Dealer

end

class Hand

end

class TwentyOne

end