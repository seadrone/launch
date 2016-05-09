# 1.  
# class SecretFile
#   def initialize(secret_data, logger)
#     @data = secret_data
#     @logger = logger
#   end
  
#   def data
#     @logger.create_log_entry
#     @data
#   end
  
# end

# class SecurityLogger
#   def create_log_entry
#     puts "Created log entry"
#   end
# end

# 2.  
module Transportation
  attr_accessor :speed, :heading
  attr_writer :fuel_capacity, :fuel_efficiency
  def range
    @fuel_capacity * @fuel_efficiency
  end
end

class WheeledVehicle
  include Transportation
    
  def initialize(tire_array, km_traveled_per_liter, liters_of_fuel_capacity)
    @tires = tire_array
    self.fuel_efficiency = km_traveled_per_liter
    self.fuel_capacity = liters_of_fuel_capacity
  end
  
  def tire_pressure(tire_index)
    @tires[tire_index]
  end
  
  def inflate_tire(tire_index, pressure)
    @tire[tire_index] = pressure
  end
end

class Auto < WheeledVehicle
  def initialize
    super([30, 30, 32, 32], 50, 25.0)
  end
end

class Motorcycle < WheeledVehicle
  def initialize
    super([20, 20], 80, 8.0)
  end
end

class Seacraft
  include Transportation

  attr_accessor :hull_count, :propeller_count
  def initialize(num_propellers, num_hulls, fuel_efficiency, fuel_capacity)
    @propeller_count = num_propellers
    @hull_count = num_hulls
    @fuel_efficiency = fuel_efficiency
    @fuel_capacity = fuel_capacity
  end
  
  def range
    range_fuel = super
    return range_fuel + 10
  end
end

class Catamaran < Seacraft
  def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
    super
  end
end

class Motorboat
  def initialize(km_traveled_per_liter, liters_of_fuel_capacity)
    super(1, 1, km_traveled_per_liter, liters_of_fuel_capacity)
  end
end