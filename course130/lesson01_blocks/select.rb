def select(array)
  counter = 0
  result = []
  while counter < array.size
    current_element = array[counter]
    result << current_element if yield(current_element)
    counter += 1
  end
  result
end

array = [1, 2, 3, 4, 5]

# p array.select { |num| num.odd? }       # => [1, 3, 5]
p array.select { |num| puts num }       # => [], because "puts num" returns nil and evaluates to false
# p array.select { |num| num + 1 }        # => [1, 2, 3, 4, 5], because "num + 1" evaluates to true