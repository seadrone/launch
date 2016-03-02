# 1
if false
  greeting = "hello world"
end

puts greeting.inspect
# greeting is nil. an variable will evaluate to nil if initialized in an unexecuted block

# 2
greetings = { a: 'hi' }
informal_greeting = greetings[:a]
# informal_greeting << ' there'
informal_greeting += " there"
puts informal_greeting
puts greetings

# 3A
# def mess_with_vars(one, two, three)
#   one = two
#   two = three
#   three = one
# end

# one = "one"
# two = "two"
# three = "three"

# mess_with_vars(one, two, three)

# puts "one is: #{one}"
# puts "two is: #{two}"
# puts "three is: #{three}"

# 3B
# def mess_with_vars(one, two, three)
#   one = "two"
#   two = "three"
#   three = "one"
# end

# one = "one"
# two = "two"
# three = "three"

# mess_with_vars(one, two, three)

# puts "one is: #{one}"
# puts "two is: #{two}"
# puts "three is: #{three}"

# 3C
# def mess_with_vars(one, two, three)
#   one.gsub!("one","two")
#   two.gsub!("two","three")
#   three.gsub!("three","one")
# end

# one = "one"
# two = "two"
# three = "three"

# mess_with_vars(one, two, three)

# puts "one is: #{one}"
# puts "two is: #{two}"
# puts "three is: #{three}"

# 4
def create_UUID()
  possible_chars = []
  ('a'..'f').each {|letter| possible_chars << letter }
  (0..9).each {|num| possible_chars << num.to_s }
  
  format = [8, 4, 4, 4, 12]
  uuid = ""
  format.each do |num|
    num.times do
      uuid += possible_chars.sample
    end
    uuid += '-'
  end
  uuid.chop
end

# 5
def dot_separated_ip_address?(input_string)
  dot_separated_words = input_string.split(".")
  return false unless dot_separated_words.count('.') == 4

  while dot_separated_words.size > 0 do
    word = dot_separated_words.pop
    return false unless is_a_number?(word)
  end
  return true
end

