array = ["I", "am", "a", "programmer", "!"]
array.each_with_index do |value,index|
  puts "At index #{index} is #{value}"
end

array2 = array.map do |item|
  item + "!!!"
end
p array2
