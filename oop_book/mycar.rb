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

  def change_color(new_color)
    self.color = new_color
    puts "Your car is #{color} now"
  end

end

highlander = MyCar.new("2012", "Black", "Highlander")
highlander.change_color("Red")
puts highlander.year
highlander.year = "2014"
puts highlander.year
highlander.color = "blue"
puts highlander.color