
def say_stop
  puts "How are you? (type 'STOP' to quit)"
  input = gets.chomp
  while input != "STOP"
    puts input.upcase
    input = gets.chomp
  end
end

p say_stop

names = ['Adam', 'Bob', 'Carol', 'Dan', 'Ed', 'Frank', 'George']

names.each_with_index do |name, index|
  puts "#{index + 1}. #{name}"
end

def countdown(num)
  if num <= 0
    puts num
  else
    puts num
    countdown(num - 1)
  end
end
p countdown(-5)
p countdown(10)