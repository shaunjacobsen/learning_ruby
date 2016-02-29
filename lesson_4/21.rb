require 'pry'

deck = [2,2,2,2,3,3,3,3,4,4,4,4,5,5,5,5,6,6,6,6,7,7,7,7,8,8,8,8,9,9,9,9,10,10,10,10] +
       ["Jack","Jack","Jack","Jack","Queen","Queen","Queen","Queen","King","King","King","King"] +
       ["Ace","Ace","Ace","Ace"]

VALUES = { "King": 10, "Queen": 10, "Jack": 10 }

players_cards = []
dealers_cards = []

player_score = 0
dealer_score = 0

def prompt(msg)
  puts "=> #{msg}"
end

def show_cards(player)
  player.join(", ")
end

def deal(quantity, cards, recipient)
  quantity.to_i.times do |x|
    recipient << cards.delete_at(rand(cards.length))
  end
  recipient.last
  binding.pry
end

def get_value(cards)
  sum = 0
  cards.each do |n|
    if n.is_a? Integer
      sum += n
    elsif n.is_a? String
      case n
      when "Jack", "Queen", "King"
        sum += 10
      else
        sum += 0
      end
    end
  end
  sum
end

def increase_score(recipient, value)
  if value.is_a? Integer
    recipient += value
  elsif value.is_a? String
    recipient += values_at(value)
  end
end

def determine_value(card, deck, player)
  player_score = get_value(deck, player)
  if (player_score + 11) < 21
    11
  else
    1
  end
end

def end_game?(player, dealer)
  get_value(player) >= 21 || get_value(dealer) >= 21
end

def winner(player, dealer)
  if get_value(player) > 21 || (get_value(player) < get_value(dealer) && get_value(dealer) < 22)
    puts "You lost."
  elsif get_value(dealer) > 21 || (get_value(player) > get_value(dealer) && get_value(player) < 22)
    puts "You won!"
  else
    puts "It's a tie."
  end
end

deal(2, deck, players_cards)
deal(2, deck, dealers_cards)

prompt("Your cards: #{show_cards(players_cards)}")
prompt("Dealer's cards: #{dealers_cards.first}, unknown")

loop do
  prompt("Hit or Stay?")
  answer = gets.chomp

  break if answer.start_with?('s')

  new_card = deal(1, deck, players_cards)
  p increase_score(player_score, new_card)
  prompt("Your cards: #{show_cards(players_cards)}")

  break if end_game?(players_cards, dealers_cards)
end

prompt "End of game"
prompt "You had #{player_score} total points"
prompt "Dealer had #{dealer_score} total points"
prompt winner(players_cards, dealers_cards)