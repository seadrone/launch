# 1
# class Person
#   attr_accessor :name
#   def initialize(name)
#     @name = name
#   end
# end

# bob = Person.new('bob')
# p bob.name                  # => 'bob'
# bob.name = 'Robert'
# p bob.name                  # => 'Robert'

# 2
# class Person
#   attr_accessor :first_name, :last_name
#   def initialize(full_name)
#     split_name = full_name.split
#     @first_name = split_name.first
#     @last_name = split_name.size > 1 ? split_name.last : ''
#   end
  
#   def name
#     "#{first_name} #{last_name}".strip
#   end
  
# end

# bob = Person.new('Robert')
# p bob.name                  # => 'Robert'
# p bob.first_name            # => 'Robert'
# p bob.last_name             # => ''
# bob.last_name = 'Smith'
# p bob.name                  # => 'Robert Smith'

# 3, 4, 5
class Person
  attr_accessor :first_name, :last_name
  
  def initialize(full_name)
    parse_full_name(full_name)
  end
  
  def name
    "#{first_name} #{last_name}".strip
  end
  
  def name=(full_name)
    parse_full_name(full_name)
  end
  
  private
  
  def parse_full_name(full_name)
    split_name = full_name.split
    self.first_name = split_name.first
    self.last_name = split_name.size > 1 ? split_name.last : ''
  end
  
  def to_s
    name
  end
  
end

bob = Person.new("Robert Smith")
rob = Person.new("Robert Smith")

p bob.object_id
p rob.object_id

puts bob.name == rob.name
puts "\n"
puts "The person's name is: " + bob.name
puts "\n"
puts "The person's name is: #{bob}"