def prompt(message)
  Kernel.puts("=> #{message}")
end

def valid_number?(num)
  num.to_i() != 0
end

def operation_to_message(op)
  case op
  when '1'
    'Adding'
  when '2'
    'Subtracting'
  when '3'
    'Multiplying'
  when '4'
    'Dividing'
  end
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

  operator_prompt = <<-MSG
    What operation do you want to do?
      1) Addition
      2) Subtraction
      3) Multiplication
      4) Division
  MSG

  prompt(operator_prompt)

  operator = ''
  loop do
    operator = Kernel.gets().chomp()

    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt("Must choose 1, 2, 3, or 4")
    end
  end

  prompt("#{operation_to_message(operator)} the numbers...")

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