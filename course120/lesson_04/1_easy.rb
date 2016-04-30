# 1. You can check an object's class by using .class 
# true is a trueclass
# "hello", is a string
# [1,2,3,'happy days'] is an array
# 142 is an fixnum

# 2, 3
# module Speed
#   def go_fast
#     puts "I am a #{self.class} and going super fast!"
#   end
# end

# class Car
#   include Speed
#   def go_slow
#     puts "I am safe and driving slow."
#   end
# end

# class Truck
#   include Speed
#   def go_very_slow
#     puts "I am a heavy truck and like going very slow."
#   end
# end

# car = Car.new
# car.go_fast

# truck = Truck.new
# truck.go_fast

# self refers to the calling object, which is an instance of Car or Truck

# 4. 
# class AngryCat
#   def hiss
#     puts "Hisss!!!"
#   end
# end

# cat = AngryCat.new
# cat.hiss

# 5. 
# class Fruit
#   def initialize(name)
#     name = name
#   end
# end

# class Pizza
#   def initialize(name)
#     @name = name
#   end
# end

# f = Fruit.new('Banana')
# piz = Pizza.new('Pepperoni')

# p f.instance_variables
# p piz.instance_variables

# Fruit does not have instance variables
# Pizza does 

# 6. This can be done by adding an attr_reader for volume or a get_volume method 
# which returns volume
# class Cube
#   # attr_reader :volume
#   def initialize(volume)
#     @volume = volume
#   end
#   def get_volume
#     @volume
#   end
# end
# cube = Cube.new(5000)
# p cube.get_volume

# 7.
# to_s prints the object's class and object id
# You can always check the documentation to be sure

# 8. self refers to the object that called it. An instance of the class
# class Cat
#   attr_accessor :type, :age
#   def initialize(type)
#     @type = type
#     @age = 0
#   end
  
#   def make_one_year_older
#     self.age += 1
#   end
# end

# 9. self in this context refers to the class Cats
# 10. You need to create a new Bag object
#  bag = Bag.new('red', 'plastic')