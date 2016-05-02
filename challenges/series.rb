class Series
  attr_accessor :series

  def initialize(num)
    num_to_array = num.split('')
    array_of_numbers = []
    num_to_array.each do |num|
      array_of_numbers << num.to_i
    end
    @series = array_of_numbers
  end

  def slices(num)
    unless num <= series.length
      raise ArgumentError.new("The requested slice length must be at or below the length of the number passed.")
    end
    sliced_nums = []
    series.size.times do
      sliced_nums << series.slice(0, num)
      series.shift
    end
    sliced_nums.delete_if { |slice| slice.length < num }
    sliced_nums
  end
end

series = Series.new('982347')
p series.series
p series.slices(3)
