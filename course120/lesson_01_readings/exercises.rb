module Greeting
end

class Person
  include Greeting
end

fred = Person.new

module Towable
  def is_towable?(lbs)
    lbs < 3000 ? true : false
  end
end

class Vehicle
  @@number_of_vehicles = 0
  attr_accessor :color, :model
  attr_reader :year
  
  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @current_speed = 0
    @@number_of_vehicles += 1
  end
  
  def self.number_of_vehicles
    @@number_of_vehicles
  end
  
  def spray_paint(color)
    self.color = color
    puts "The car's new color is #{color}"
  end
  
  def self.calculate_mileage(gallons, miles)
    puts "#{miles/gallons} mpg"
  end
  
  def years_old
    "This #{self.model} is #{calculate_years_old} years old."
  end
  
  private
  
  def calculate_years_old
    Time.now.year - self.year
  end
  
end

class MyCar < Vehicle
  NUMBER_OF_DOORS = 4
  def to_s
    "This car is a #{color} #{year} #{model}."
  end
end

class MyTruck < Vehicle
  include Towable
  NUMBER_OF_DOORS = 2
  def to_s
    "This truck is a #{color} #{year} #{model}."
  end
end

mazda = MyCar.new(2004, 'blue', 'Mazda3')
MyCar.calculate_mileage(12, 250)
puts mazda
chevy = MyTruck.new(2005, 'silver', 'Chevy Silverado')
puts chevy
puts Vehicle.number_of_vehicles
puts MyCar.ancestors
puts "\n"
puts MyTruck.ancestors
puts "\n"
puts Vehicle.ancestors
puts mazda.years_old


class Student
  def initialize(name, grade)
    @name = name
    @grade = grade
  end
  
  def better_grade_than?(other_student)
    grade > other_student.grade
  end
  
  protected
  
  def grade
    @grade
  end
  
end

sue = Student.new('Sue', 75)
kev = Student.new('Kev', 80)
puts "Well done!" if kev.better_grade_than?(sue)


# CLasses and Objects II, Ex 3 NoMethodError
# The code produces the error because name only has a getter method associated with it from attr_reader.
# One could fix the error by using attr_accessor :name so that @name is both readable and writeable.

# Inheritance Ex 8
# hi is a private method and not available to the bob object. It can be fixed by removing the private 
# designation before the hi method definition.
