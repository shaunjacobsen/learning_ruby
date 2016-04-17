require 'pry'

class Luhn
  attr_accessor :number, :number_parts, :reversed_number_parts, :returned_array, :check_digit

  def initialize(number)
    @number = number
    @number_parts = number.to_s.split('').map(&:to_i)
    @reversed_number_parts = number.to_s.reverse.split('').map(&:to_i)
  end

  def addends
    @returned_array = reversed_number_parts
    reversed_number_parts.map.with_index do |num, idx|
      if idx.odd?
        ((num * 2) > 10) ? new_num = ((num * 2) - 9) : new_num = (num * 2)
        returned_array[idx] = new_num
      else
        num
      end
    end
    returned_array.reverse
  end

  def checksum
    check_digit = addends.inject(&:+)
    check_digit
  end

  def valid?
    checksum.to_s.split('').last == '0' ? true : false
  end

end

cc = Luhn.new(8739567)
p cc.number_parts
p cc.reversed_number_parts
p cc.valid?