require 'pry'

CARDS = [["2", 2], ["3", 3], ["4", 4], ["5", 5], ["6", 6], ["7", 7], ["8", 8], ["9", 9], ["10", 10]] +
        [["Jack", 10], ["Queen", 10], ["King", 10], ["Ace", 0]]

deck = []

dealer_score = 0
player_score = 0

dealer_cards = []
player_cards = []

def prompt(msg)
  puts "=> #{msg}"
end

def get_cards(hand)
  joined_hand = []
  hand.map { |c| joined_hand << c[1] }
  joined_hand.join(', ')
end

def initialize_deck(cards, deck)
  suits = %w(Hearts Spades Clubs Diamonds)
  suits.each do |s|
    cards.each do |c|
      deck << [s, c].flatten
    end
  end
  deck
end

def deal(qty, hand, deck, recipient)
  score = 0
  qty.times do |x|
    returned_card = deck.delete_at(rand(deck.length))
    returned_card_value = determine_card_value(returned_card, recipient)
    hand << returned_card
    score += returned_card_value
  end
  increment_score(recipient, score)
end

def determine_card_value(card, score)
  if card[1] == "Ace"
    if (score + 10) <= 21
      card[2] = 11
    else
      card[2] = 1
    end
  end
  card[2]
end

def dealer_hits?(score)
  score <= 17
end

def at_or_over_21?(score)
  score >= 21
end

def who_won?(player, dealer)
  case
  when (player > dealer) && player <= 21
    "Player won!"
  when (player > dealer) && player > 21
    "Dealer won!"
  when (dealer > player) && dealer <= 21
    "Dealer won!"
  when (dealer > player) && dealer > 21
    "Player won!"
  else
    "It's a tie."
  end
end

def increment_score(recipient, amount)
  recipient += amount
end

initialize_deck(CARDS, deck)

prompt "Dealing cards..."
player_score = deal(2, player_cards, deck, player_score)
dealer_score = deal(2, dealer_cards, deck, dealer_score)
prompt "Your hand:"
puts get_cards(player_cards)

prompt "Dealer's hand:"
puts dealer_cards[0][1] + ", unknown"

until (at_or_over_21?(player_score) || at_or_over_21?(dealer_score)) do
  prompt "Hit [h] or Stay [s]?"
  answer = gets.chomp

  if answer.downcase.start_with?('s')
    if dealer_hits?(dealer_score)
      dealer_score = deal(1, dealer_cards, deck, dealer_score)
    else break
    end
  elsif answer.downcase.start_with?('h')
    player_score = deal(1, player_cards, deck, player_score)
    prompt "Your hand:"
    puts get_cards(player_cards)
    prompt "Your score:"
  end
end

prompt "Your hand: #{get_cards(player_cards)}"
prompt "Your score: #{player_score}."
prompt "Dealer's hand, revealed: #{get_cards(dealer_cards)}"
prompt "Dealer's score: #{dealer_score}."
puts who_won?(player_score, dealer_score)