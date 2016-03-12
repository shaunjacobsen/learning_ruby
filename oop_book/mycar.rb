class MyCar
  attr_accessor :color, :speed
  attr_reader :year, :model

  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @speed = 0
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

end

highlander = MyCar.new("2012", "Black", "Highlander")
highlander.spray_paint("Red")
puts highlander.year