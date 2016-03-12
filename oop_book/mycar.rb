class MyCar
  attr_accessor :year, :color, :model, :speed

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

end