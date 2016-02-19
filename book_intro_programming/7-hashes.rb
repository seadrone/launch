# 1. .select method
family = {
  uncles: ['bob', 'joe', 'steve'],
  sisters: ['jane', 'jill', 'beth'],
  brothers: ['frank', 'rob', 'david'],
  aunts: ['mary', 'sally', 'susan']
}

immediate_family = family.select do |k,v|
  k == :sisters || k == :brothers
end

result = immediate_family.values.flatten

p result

# 2. merge method
hash1 = {first: 10, second: 20}
hash2 = {second: 28, third: 30}

hash_merged = hash1.merge(hash2)

boys = {'a' => 'Adam', 'b' => "Brian"}
girls = {'b' => 'Becky', 'c' => 'Charlotte'}

boys.merge!(girls)

# 3a print keys
print_hash = {name: "Bob", age: 34, eyes: 'green', hair: 'brown'}

print_hash.each do |k,v| 
  puts "key: #{k}"
end

# 3b print values
print_hash.each do |k,v|
  puts "values: #{v}"
end

# 3c print keys and values
print_hash.each do |k,v|
  puts "key: #{k}, value: #{v}"
end

# 4. access name
person = {name: 'Bob', occupation: 'web developer', hobbies: 'painting'}
person[:name]

# 5. Search for a specific value
if person.has_value?("web dev")
  puts "Yes"
else
  puts "No"
end

# 6. Anagram search
words =  ['demo', 'none', 'tied', 'evil', 'dome', 'mode', 'live',
          'fowl', 'veil', 'wolf', 'diet', 'vile', 'edit', 'tide',
          'flow', 'neon']
results = {}
words.each do |word|
  key = word.split('').sort.join
  if results.has_key?(key)
    results[key].push(word)
  else
    results[key] = [word]
  end
end

results.each do |key,val|
  puts ""
  p val
end

puts results






