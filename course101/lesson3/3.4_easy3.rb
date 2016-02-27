# 1
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

# 2
flintstones << "Dino"

# 3
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
p flintstones << "Dino" << "Hoppy"
# flintstones.push("Dino").push("Hoppy")

# 4
advice = "Few things in life are as important as house training your pet dinosaur."
puts advice.slice!(0, advice.index('house')) 
# puts advice.slice!(advice.index('house'), advice.length)
# The #slice method is non-destructive. It will not affect the original advice variable

# 5
statement = "The Flintstones Rock!"
p statement.scan('t').length

# 6
title = "Flintstone Family Members"
puts title.center(40)