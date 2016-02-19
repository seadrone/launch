module Greeter
  def hello name
    puts "Hello, #{name}!"
  end
  
  def goodbye name
    puts "Goodbye, #{name}."
  end
end

class Person
  include Greeter
  attr_reader :name
  def initialize name
    @name = name
  end
end

module TutsPlus
  
  class User
    attr_reader :id
    include Greeter
    def initialize id
      @id = id
    end
  end
end

person = Person.new("Jose")
person.hello("Bob")
person.goodbye("Bob")
puts person.name
user = TutsPlus::User.new("Sarah")
user.hello("Jane")
puts user.id