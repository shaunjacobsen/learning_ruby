# loan calculator
#
# should ask the user for the loan amount, APR, and duration in months
# first get interest / 100 / 12 (c)

require 'pry'

def prompt(message)
	puts "=> #{message}"
end

def is_int?(num)
  num.to_i.to_s == num
end

def is_float?(num)
  num.to_f == num
end

def is_not_negative?(num)
  num.to_i > 0
end

prompt("Hello, welcome to the monthly loan payment calculator!")
prompt("How much will you be taking out?")
prompt("Please enter whole numbers only:")

amount = ''
loop do
  amount = gets.chomp
  if is_int?(amount) && is_not_negative?(amount)
    break
  else
    prompt "Please enter a valid number with no commas or decimals greater than $1 in value:"
  end
end

prompt("Ok, $#{amount}. Over how many months will you make payments?")

duration = ''
loop do
  duration = gets.chomp
  if is_int?(duration)
    break
  else
    prompt("Please enter a whole number of months:")
  end
end

prompt("Finally, what is the annual interest rate (APR)?")
prompt("Please enter only the percentage, including decimals:")

user_rate = ''
loop do
  user_rate = gets.chomp.to_f
  if is_float?(user_rate)
    break
  else
    prompt("Please only enter the number, with no trailing '%':")
  end
end

interest = user_rate / 100
monthly_interest = interest / 12

# set all number-strings to numbers
amount = amount.to_i
duration = duration.to_i

prompt("Ok, a $#{amount} loan paid over #{duration} months at #{user_rate}% APR.")

monthly_payment = amount * (monthly_interest * (1 + monthly_interest) ** duration) / (((1 + monthly_interest) ** duration) - 1)

prompt("Your monthly payment is $#{monthly_payment.round(2)}.")

