def prompt(message)
  Kernel.puts("=> #{message}")
end

prompt("Welcome to calculator!")

# get the first number
prompt("What is the first number?")
number1 = Kernel.gets().chomp()

#get the second number 
prompt("And the second number")
number2 = Kernel.gets().chomp()

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