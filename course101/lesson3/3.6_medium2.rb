# 1
munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" }
}

total_age = 0
munsters.each do |name, data|
  total_age += data["age"] if data["gender"] == "male"
end

# 2
munsters.each do |name, data|
  puts name + " is a #{data["age"]} year old " + data["gender"]
end

# 3
def not_so_tricky_method(a_string_param, an_array_param)
  a_string_param += "rutabaga"
  an_array_param += ["rutabaga"]

  return a_string_param, an_array_param
end

my_string = "pumpkins"
my_array = ["pumpkins"]
my_string, my_array = not_so_tricky_method(my_string, my_array)

puts "My string looks like this now: #{my_string}"
puts "My array looks like this now: #{my_array}"

# 4
sentence = "Humpty Dumpty sat on a wall."
puts sentence.chop.split.reverse.join(' ')

# 5
# The output is 34. answer is still 42. new_answer is 50

# 6
