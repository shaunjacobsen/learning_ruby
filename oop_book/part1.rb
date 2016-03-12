class GoodDog
  def initialize(name)
    @name = name
  end

  def speak
    "#{@name} says woof!"
  end
end

makoto = GoodDog.new("Makoto")
puts makoto.speak