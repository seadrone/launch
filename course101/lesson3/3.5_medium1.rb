# 1
10.times {|i| puts (" "*i) + "The Flintstones Rock!" }

# 2
statement = "The Flintstones Rock"
statement_arr = statement.chars
statement_arr.delete(" ")
statement_hash = {}
statement_arr.each do |char|
  if statement_hash[char]
    statement_hash[char] += 1
  else 
    statement_hash[char] = 1
  end
end
p statement_hash

# 3 Ruby can't concatenate a string and an Integer.
# You can use string interpolation or convert (40+2).to_s

# 4
numbers = [1, 2, 3, 4]
numbers.each do |number|
  p number
  numbers.shift(1)
end

numbers = [1, 2, 3, 4]
numbers.each do |number|
  p number
  numbers.pop(1)
end

# 5
def factors(number)
  iterator = number
  factors_array = []
  puts "Please use a number greater than 0." if number <= 0 
  while iterator > 0
    factors_array << iterator if number % iterator == 0
    iterator -= 1
  end
  factors_array
end

factors(-6)
p factors(24)

# 7
def fib(first_num, second_num)
  limit = 15
  while second_num < limit
    sum = first_num + second_num
    first_num = second_num
    second_num = sum
  end
  sum
end

result = fib(0, 1)
puts "result is #{result}"

# 8
a_string = "the rain in spain"
a_string.split.map {|word| word.capitalize }.join(' ')

# 9
munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

new_munsters = munsters.each do |munster, stats|
  case stats["age"]
  when 0..17
    stats["age_group"] = "kid"
  when 18..64
    stats["age_group"] = "adult"
  else
    stats["age_group"] = "senior"
  end
end
p new_munsters