class Series
  attr_accessor :series

  def initialize(num)
    num_to_array = num.split('')
    array_of_numbers = []
    num_to_array.each do |num|
      array_of_numbers << [num.to_i]
    end
    @series = array_of_numbers
  end

  def slices(num)
    series
  end
end

series = Series.new('1234')
p series.series