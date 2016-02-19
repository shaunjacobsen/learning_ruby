# ask the user for two numbers
# ask for an operation to perform
# perform the operation on the two numbers
# output result

Kernel.puts("Welcome to calculator!")

# get the first number
Kernel.puts("Please enter the first number")
number1 = Kernel.gets().chomp()

#get the second number 
Kernel.puts("And the second number")
number2 = Kernel.gets().chomp()

Kernel.puts("What operation would you like to perform? 1) add 2) subtract 3) multiply 4) divide")
operator = Kernel.gets().chomp()

if operator == '1'
  result = number1.to_i() + number2.to_i()
elsif operator == '2'
  result = number1.to_i() - number2.to_i()
elsif operator == '3'
  result = number1.to_i() * number2.to_i()
elsif operator == '4'
  result = number1.to_f() / number2.to_f()
end

Kernel.puts("Result: #{result}")