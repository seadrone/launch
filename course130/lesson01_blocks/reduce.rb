def reduce(arr, start = 0)
  counter = 0
  memo = start
  
  while counter < arr.size
    memo = yield(memo, arr[counter])
    counter += 1
  end
  memo
end


array = [1, 2, 3, 4, 5]

# p reduce(array) { |acc, num| acc + num }                    # => 15
# reduce(array, 10) { |acc, num| acc + num }                # => 25
p reduce(array) { |acc, num| acc + num if num.odd? }        # => NoMethodError: undefined method `+' for nil:NilClass