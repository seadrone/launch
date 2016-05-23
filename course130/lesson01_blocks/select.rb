def select
  counter = 0
  arr = []
  while counter < array.size
    arr << yield(arr[counter]) if yield(arr[counter])
    counter += 1
  end
  puts arr if arr
end

array = [1, 2, 3, 4, 5]

# p array.select { |num| num.odd? }       # => [1, 3, 5]
p array.select { |num| puts num }       # => [], because "puts num" returns nil and evaluates to false
# p array.select { |num| num + 1 }        # => [1, 2, 3, 4, 5], because "num + 1" evaluates to true