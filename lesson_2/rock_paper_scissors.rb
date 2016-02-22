VALID_CHOICES = %w(rock paper scissors)

def prompt(message)
  puts("=> #{message}")
end

def win?(first, second)
  (first == 'rock' && second == 'scissors') ||
    (first == 'paper' && second == 'rock') ||
    (first == 'scissors' && second == 'paper')
end

def display_result(player, computer)
  if win?(player, computer)
    prompt("You won!")
  elsif win?(computer, player)
    prompt("Computer won.")
  else
    prompt("It's a tie!")
  end
end

loop do
  choice = ''
  loop do
    prompt("Choose one: #{VALID_CHOICES.join(', ')}. Type just the first letter.")
    choice = gets.chomp
    if choice.length == 1
      case
      when choice.downcase == 'r'
        choice = 'rock'
      when choice.downcase == 'p'
        choice = 'paper'
      when choice.downcase == 's'
        choice = 'scissors'
      else choice = ''
      end
    else
      break
    end

    if VALID_CHOICES.include?(choice)
      break
    else
      prompt("That's not a valid choice.")
    end
  end

  computer_choice = VALID_CHOICES.sample

  puts("You chose #{choice}.\nComputer chose #{computer_choice}.")

  display_result(choice, computer_choice)

  prompt("Do you want to play again?")
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt("Thanks for playing. Bye!")
