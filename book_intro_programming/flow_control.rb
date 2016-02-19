a = 5
case 
  when a == 5
    puts "a is 5"
  when a == 6
    puts "a is 6"
  else 
    puts "a is neither 5 nor 6"
end

def caps(string)
  len = string.length
  if len > 10 
    string.upcase
  else
    string
  end
end
p caps("alabaster brow")
p caps("cat")

def number_check(number)
  if number < 0
    puts "Your number must be positive"
  elsif number <= 50
    puts "#{number} is between 0 and 50"
  elsif number <= 100
    puts "#{number} is between 51 and 100"
  else
    puts "#{number} is greater than 100"
  end
end

# 4.1. false
# 4.2. Did you get it right?
# 4.3. Alright now!

def number_check2(number)
  case number
    when 0..50
      puts "#{number} is between 0 and 50"
    when 51..100
      puts "#{number} is between 51 and 100"
    else
      if number < 0
        puts "Number must be greater than zero."
      else number > 100
        puts "#{number} is greater than 100"
      end
  end
end

puts "Please enter a number between 0 and 100: "
input = gets.chomp.to_i
number_check(input)
number_check2(input)

# Error occurs because the conditional statement is missing and end
