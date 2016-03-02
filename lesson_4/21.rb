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

def initialize_deck(cards, deck)
  suits = %w(Hearts Spades Clubs Diamonds)
  suits.each do |suit|
    cards.each do |card|
      deck << [suit, card].flatten
    end
  end
  deck
end

def show_cards(hand)
  joined_hand = hand.map { |card| card[1] }
  joined_hand.join(', ')
end

def obscure_cards(hand)
  cards_to_hide = hand.drop(1)
  unknown_string = cards_to_hide.length.times.collect { ", unknown" }.join
  hand[0][1] + unknown_string
end

def deal(qty, hand, deck, recipient)
  score = 0
  qty.times do
    returned_card = deck.delete_at(rand(deck.length))
    hand << returned_card
  end
  increment_score(recipient, score)
end

def hand_value(hand)
  card_values = []
  sorted_hand = hand.sort_by { |card| card[2] }.reverse
  sorted_hand.each do |card|
    if card[1] == "Ace"
      if (card_values.inject(:+) + 10) <= 21
        card[2] = 11
      else
        card[2] = 1
      end
      card_values << card[2]
    else
      card_values << card[2]
    end
  end
  card_values.inject(:+)
end

def dealer_hits?(score)
  score <= 17
end

def bust?(score)
  score > 21
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
deal(2, player_cards, deck, player_score)
deal(2, dealer_cards, deck, dealer_score)

player_score = hand_value(player_cards)
dealer_score = hand_value(dealer_cards)

prompt "Your hand: #{show_cards(player_cards)}"
prompt "Dealer's hand: #{obscure_cards(dealer_cards)}"

until (bust?(player_score) || bust?(dealer_score))
  prompt "Hit [h] or Stay [s]?"
  answer = gets.chomp

  if answer.downcase.start_with?('s')
    if dealer_hits?(dealer_score)
      prompt "Dealing card to dealer..."
      deal(1, dealer_cards, deck, dealer_score)
      dealer_score = hand_value(dealer_cards)
      prompt "Dealer's hand: #{obscure_cards(dealer_cards)}"
    else
      break
    end
  elsif answer.downcase.start_with?('h')
    prompt "Dealing card to you..."
    deal(1, player_cards, deck, player_score)
    player_score = hand_value(player_cards)
    prompt "Your hand: #{show_cards(player_cards)}"
  end
end

prompt "Game over!\n"
prompt "Your score: #{player_score}."
prompt "Dealer's hand, revealed: #{show_cards(dealer_cards)}"
prompt "Dealer's score: #{dealer_score}."
puts who_won?(player_score, dealer_score)