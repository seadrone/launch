def greeting(name)
  p "Hello, #{name}"
end
greeting("Joe")



# 3. Multiply method
def multiply(x,y)
  x * y
end
p multiply(2,3)

# 4. and 5. Scream method
def scream(words)
  words = words + "!!!!"
  puts words
end
scream("Hello world")
