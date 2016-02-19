# 1.
array1 = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
array1.each do |num|
  puts num
end

# 2.
array1.each do |num|
  if num > 5
    puts num
  end
end

# 3.
array2 = array1.select { |num| num % 2 == 1 }
p array2

# 4.
array1.unshift(0)
array1.push(11)
p array1

# 5. 
popped_val = array1.pop
array1.push(3)
p array1

# 6.
array1.uniq

# 7. hashes use a key/value pair but an array uses and index/value

# 8.
hash1 = {:age => 34}
hash2 = {age: 34}

# 9. 
h = {a:1, b:2, c:3, d:4}
puts h[:b]
h[:e] = 5
h2    = h.select {|key,val| val>3.5}
p h2

# 12.
contact_data = [["joe@email.com", "123 Main st.", "555-123-4567"],
            ["sally@email.com", "404 Not Found Dr.", "123-234-3454"]]

contacts = {"Joe Smith" => {}, "Sally Johnson" => {}}

contacts["Joe Smith"][:email]       = contact_data[0][0]
contacts["Joe Smith"][:address]     = contact_data[0][1]
contacts["Joe Smith"][:phone]       = contact_data[0][2]
contacts["Sally Johnson"][:email]   = contact_data[1][0]
contacts["Sally Johnson"][:address] = contact_data[1][1]
contacts["Sally Johnson"][:phone]   = contact_data[1][2]

# 13
puts contacts["Joe Smith"][:email]
puts contacts["Sally Johnson"][:phone]

# 14.
contact_data2 = ["joe@email.com", "123 Main st.", "555-123-4567"]
contacts2 = {"Joe Smith" => {}}
fields    = [:email, :address, :phone]

contacts2.each do |name, info|
  fields.each do |field|
    info[field] = contact_data2.shift
  end
end

puts contacts2

# 14 bonus
cd = [["john@mail.com", "444 Holly St.", "777-745-9863"], 
      ["suzy@mail.com", "125 Maple Ln.", "555-666-9999"], 
      ["andy@mail.com", "999 Nine Ln.", "579-983-7844"]]
c  = {"John Smith" => {}, "Suzy Jones" => {}, "Andy Green" => {}}

c.each_with_index do |(name, hash), index|
  fields.each do |field|
    hash[field] = cd[index].shift
  end
end

p c

# 15.
arr = ['snow', 'winter', 'ice', 'slippery', 'salted roads', 'white trees']

arr.each do |word|
  arr.delete_if { |word| word.start_with?('s')}
end
p arr

arr2 = ['snow', 'winter', 'ice', 'slippery', 'salted roads', 'white trees']

arr2.each do |word|
  arr2.delete_if {|word| word.start_with?('s', 'w')}
end
p arr2

# 16.
a = ['white snow', 'winter wonderland', 'melting ice',
     'slippery sidewalk', 'salted roads', 'white trees']
a2 = a.map {|i| i.split}
p a2.flatten






