def select(array)
  counter = 0
  results = []

  while counter < array.size do
    current = array[counter]
    if yield(current) 
      results << current
    end
    counter += 1
  end

  results
end

p select([1,2,3,4,5]) { |num| num.odd? }