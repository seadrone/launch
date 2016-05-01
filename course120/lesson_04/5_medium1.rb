# 1.  Ben is correct. The attr_reader allows the balance instance variable to be used without the @
# 2.  It will fail at update_quantity because the quantity variable is not setable. You can fix it 
#     by adding attr_accessor :quantity and referring to it as self.quantity.
# 3.  While technically correct, the quantity variable can now be changed by just setting it directly,
#     instead of using the update_quantity method.

# 4.  
# class Greeting
#   def greet(str)
#     puts str
#   end
# end

# class Hello < Greeting
#   def hi
#     greet('hello')
#   end
# end

# class Goodbye < Greeting
#   def bye
#     greet('goodbye')
#   end
# end

# 5.
# class KrispyKreme
#   def initialize(filling_type, glazing)
#     @filling_type = filling_type 
#     @glazing = glazing
#   end
  
#   def to_s
#     filling_string = @filling_type ? @filling_type : "Plain"
#     glazing_string = @glazing ? " with #{@glazing}" : ''
#     filling_string + glazing_string
#   end
# end

# donut1 = KrispyKreme.new(nil, nil)
# donut2 = KrispyKreme.new("Vanilla", nil)
# donut3 = KrispyKreme.new(nil, "sugar")
# donut4 = KrispyKreme.new("Custard", "icing")

# puts donut1
# puts donut2
# puts donut3
# puts donut4

# 6.  
# class Computer
#   attr_accessor :template
#   def create_template
#     @template = "template 14231"
#   end
  
#   def show_template
#     template
#   end
# end

# class Computer
#   attr_accessor :template
#   def create_template
#     self.template = "template 14231"
#   end
  
#   def show_template
#     self.template
#   end
# end

# comp = Computer.new
# comp.create_template
# p comp.show_template

# 7.  I would remove the light_ prefix. 