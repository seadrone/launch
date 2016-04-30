# 1. The method call samples the choice array and appends it to "You will "
# 2. The RoadTrip class will sample its own array of choices
# class Oracle
#   def predict_the_future
#     "You will " + choices.sample
#   end

#   def choices
#     ['eat a nice lunch', 'take a nap soon', 'stay at work late']
#   end
# end

# class RoadTrip < Oracle
#   def choices
#     ['visit Vegas', 'fly to Fiji', 'romp in Rome']
#   end
# end

# oracle = Oracle.new
# puts oracle.predict_the_future

# trip = RoadTrip.new
# puts trip.predict_the_future 

# 3. You can use the ancestors on the class

# 4. Add attr_accessor for the type and remove @ from the describe_type method

# 5. The first is a local variable. 
# The second is an instance variable. 
# The third is a class variable.

# 6. The first is a class method. It is prefaced by self in the class.
# The second is an instance method

# 7. The @@cats_count variable is a class variable that returns the number of instances of the Cat class there are.
# You could test it with

# class Cat
#   @@cats_count = 0
#   def initialize(type)
#     @type = type
#     @age = 0
#     @@cats_count += 1
#   end
  
#   def self.cats_count
#     @@cats_count
#   end
# end

# cat = Cat.new('tabby')
# puts Cat.cats_count

# 8. A class can inherit from a parent class by using < 
# class Game
# end

# class Bingo < Game
# end

# 9. The play method from the Bingo class would override the Game class's method

# 10.
# - avoid duplicate code
# - can fix bugs in just one place
# - better organized code