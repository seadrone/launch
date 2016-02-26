# 1. The array numbers is unchanged

# 2. The ! operator can mean not in comparisons or in a method definition it means the method is destructive or mutates the caller.
# 2.1 != means not equal to
# 2.2 ! before something means not
# 2.3 ! at the end of a method means it mutates the caller
# 2.4 ? is the ternary operator in an if...else statement
# 2.6 !! before an object returns the object's boolean equivalent
# 2.7 ! before an object returns the opposite of the object's boolean equivalent

# 3
advice = "Few things in life are as important as house training your pet dinosaur."
advice.gsub('important', 'urgent')

# 4
# #delete(n) will remove the nth item
# #delete_at(n) will remove the item at the nth index

# 5
(10..100).include?(42)
(10..100).cover?(42)

# 6
famous_words = "seven years ago..."
puts "Four score and " + famous_words
puts "Four score and " << famous_words
puts famous_words.prepend("Four score and ") 

# 7
def add_eight(number)
  number + 8
end
number = 2
how_deep = "number"
5.times { how_deep.gsub!("number", "add_eight(number)") }
eval(how_deep) # 42

# 8
flintstones = ["Fred", "Wilma"]
flintstones << ["Barney", "Betty"]
flintstones << ["BamBam", "Pebbles"]

flat_flintstones = flintstones.flatten
p flat_flintstones

# 9
flintstones = { "Fred" => 0, "Wilma" => 1, "Barney" => 2, "Betty" => 3, "BamBam" => 4, "Pebbles" => 5 }
flintstones.assoc("Barney")

# 10
flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]
flintstones.each_with_index do |name, index|
  flintstones_hash[name] = index
end