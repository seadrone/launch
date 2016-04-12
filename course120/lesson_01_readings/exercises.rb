module Greeting
end

class Person
  include Greeting
end

fred = Person.new

class MyCar
  attr_accessor :color, :model
  attr_reader :year
  
  def self.calculate_mileage(gallons, miles)
    puts "#{miles/gallons} mpg"
  end
  
  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @current_speed = 0
  end
  
  def speed_up(amt)
    @current_speed += amt
    puts "The car speeds up by #{amt} mph."
  end
  
  def brake(amt)
    @current_speed -= amt
    puts "The car slows down by #{amt} mph."
  end
  
  def turn_off
    @current_speed = 0
    puts "The engine is off."
  end
  
  def current_speed
    puts "Your current speed is #{@current_speed} mph."
  end
  
  def spray_paint(color)
    self.color = color
    puts "The car's new color is #{color}"
  end
  
  def to_s
    "This is a #{color} #{year} #{model}."
  end
  
end

mazda = MyCar.new(2004, 'blue', 'Mazda3')
MyCar.calculate_mileage(12, 250)
puts mazda

# 3 NoMethodError
# The code produces the error because name only has a getter method associated with it from attr_reader.
# One could fix the error by using attr_accessor :name so that @name is both readable and writeable.
