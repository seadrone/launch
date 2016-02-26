# 1
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }
p ages.has_key?("Spot")
p ages.include?("Spot")
p ages.key?("Spot")

# 2
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }
sum = 0
ages.each_value do |age|
  sum += age
end

# 3
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }
p ages.delete_if {|key,val| val >= 100 }

# 4
munsters_description = "The Munsters are creepy in a good way."
puts munsters_description.capitalize
puts munsters_description.swapcase
puts munsters_description.downcase
puts munsters_description.upcase

# 5
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10 }
additional_ages = {"Marilyn" => 22, "Spot" => 237}
p ages.merge(additional_ages)

# 6
ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }
puts ages.values.min

# 7 
advice = "Few things in life are as important as house training your pet dinosaur."
p advice.include?("Dino")
advice.match("Dino")

# 8
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
p flintstones.find_index {|name| name.start_with?("Be")}

# 9
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
flintstones.map! {|name| name[0..2] }