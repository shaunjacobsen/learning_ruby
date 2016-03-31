module Cargoable
  def can_carry?(kg)
    if kg <= 2000
      puts "You can carry this as cargo."
    else
      puts "This cannot be carried as cargo."
    end
  end
end

class Vehicle
  attr_accessor :color, :speed
  attr_reader :year, :model

  @@number_of_vehicles = 0

  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @speed = 0
    @@number_of_vehicles += 1
  end

  def accelerate(amount)
    speed += amount
  end

  def brake(amount)
    speed -= amount
  end

  def shutdown
    speed = 0
  end

  def spray_paint(new_color)
    self.color = new_color
    puts "Your car is #{color} now"
  end

  def self.gas_mileage(km, litres)
    puts "The fuel efficiency is #{km / litres} km per litre of gas."
  end

  def to_s
    "This is a #{@year} #{@color} #{@model}."
  end

  def self.number_of_vehicles
    puts "There are #{@@number_of_vehicles} vehicle(s) on the road."
  end

  def age
    puts "The #{@model} is #{calculate_age} years old."
  end

  private

  def calculate_age
    2016 - @year.to_i
  end

end

class MyCar < Vehicle
  WHOSE_CAR = "Shaun's"
end

class MyTruck < Vehicle
  include Cargoable
  WHOSE_TRUCK = "Not mine"
end

highlander = MyCar.new("2012", "Black", "Highlander")
highlander.spray_paint("Red")
puts highlander.year
MyCar.gas_mileage(400, 45)
puts highlander
Vehicle.number_of_vehicles
truck = MyTruck.new("2015", "Grey", "F-150")
Vehicle.number_of_vehicles
highlander.age

# Print to the screen the method lookup for the classes
puts Vehicle.ancestors
puts MyCar.ancestors
puts MyTruck.ancestors