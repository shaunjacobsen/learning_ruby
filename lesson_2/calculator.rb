def prompt(message)
  Kernel.puts("=> #{message}")
end

def valid_number?(num)
  num.to_i() != 0
end

prompt("Welcome to calculator! What's your name?")

name = ''
loop do
  name = Kernel.gets().chomp()

  if name.empty?()
    prompt("Make sure to type in your name!")
  else
    break
  end
end

prompt("Hi, #{name}!")

# main loop
loop do
  number1 = '' # initialize the number outside the 'loop' block below
  loop do
    prompt("What is the first number?")
    number1 = Kernel.gets().chomp()

    if valid_number?(number1)
      break
    else
      prompt("Please enter a valid number")
    end
  end

  number2 = ''
  loop do
    prompt("And the second number")
    number2 = Kernel.gets().chomp()

    if valid_number?(number2)
      break
    else
      prompt("Please enter a valid number")
    end
  end

  prompt("What operation would you like to perform? 1) add 2) subtract 3) multiply 4) divide")
  operator = Kernel.gets().chomp()

  result = case operator
    when '1'
      number1.to_i() + number2.to_i()
    when '2'
      number1.to_i() - number2.to_i()
    when '3'
      result = number1.to_i() * number2.to_i()
    when '4'
      result = number1.to_f() / number2.to_f()
  end

  prompt("Result: #{result}")

  prompt("Do you want to perform another calculation? Enter 'Y' for yes.")
  answer = Kernel.gets().chomp()
  break unless answer.downcase().start_with?('y')

end

prompt("Thank you for using me, bye!")