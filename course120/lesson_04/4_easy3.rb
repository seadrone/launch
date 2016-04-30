# 1. 
# class Greeting
#   def greet(message)
#     puts message
#   end
# end

# class Hello < Greeting
#   def self.hi
#     greeting = Greeting.new
#     greeting.greet("Hello")
#   end
# end

# class Goodbye < Greeting
#   def bye
#     greet("Goodbye")
#   end
# end

# hello = Hello.new
# hello.hi  # Hello
# hello.bye # undefined method error
# hello.greet # argument error 
# hello.greet("Goodbye") # Goodbye
# Hello.hi  # undefined method error

# 2. You could fix it by adding self before the hi method definition in the Hello class
# and creating a new instance of the Greeting class

# 3. 
# class AngryCat
#   def initialize(age, name)
#     @age  = age
#     @name = name
#   end

#   def age
#     puts @age
#   end

#   def name
#     puts @name
#   end

#   def hiss
#     puts "Hisssss!!!"
#   end
# end

# whiskers = AngryCat.new(2, 'Whiskers')
# joe = AngryCat.new(2, 'Joe')

# 4. 
# class Cat
#   attr_reader :type
#   def initialize(type)
#     @type = type
#   end
  
#   def to_s
#     puts "I am a #{type} cat."
#   end
# end

# whiskers = Cat.new('siamese')
# whiskers.to_s

# 5.
# tv = Television.new  
# tv.manufacturer  # since .manufacturer is a class method the result would be undefined method
# tv.model  # returns the model 

# Television.manufacturer  # returns the mfr
# Television.model  # since .model is an instance method it will result in an undefined method error

# 6. You can use @ in place of self.
# 7. The attr_accessor does not add value. There are no methods that use them yet.
# The return is not neccessary. Ruby automatically returns the last line of the method.
