deck = [2,2,2,2,3,3,3,3,4,4,4,4,5,5,5,5,6,6,6,6,7,7,7,7,8,8,8,8,9,9,9,9,10,10,10,10] +
       ["Jack","Jack","Jack","Jack","Queen","Queen","Queen","Queen","King","King","King","King"] +
       ["Ace","Ace","Ace","Ace"]

players_cards = []
dealers_cards = []

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
  recipient
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
        sum += determine_value(n)
      end
    end
  end
  sum
end

def determine_value(card)
  return 0
end

def end_game?(player, dealer)
  get_value(player) >= 21 || get_value(dealer) >= 21
end

def winner(player, dealer)
  puts "IDK"
end

deal(2, deck, players_cards)
deal(2, deck, dealers_cards)

prompt("Your cards: #{show_cards(players_cards)}")
prompt("Dealer's cards: #{dealers_cards.first}, unknown")

loop do
  prompt("Hit or Stay?")
  answer = gets.chomp

  deal(1, deck, players_cards)

  break if end_game?(players_cards, dealers_cards)
  prompt("Your cards: #{show_cards(players_cards)}")
end

prompt "End of game"
prompt "You had #{get_value(players_cards)} total points"
prompt "Dealer had #{get_value(dealers_cards)} total points"
prompt winner(players_cards, dealers_cards)