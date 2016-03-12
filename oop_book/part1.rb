class GoodDog
  attr_accessor :name, :height, :weight

  def initialize(n, h, w)
    @name = n
    @height = h
    @weight = w
  end

  def speak
    "#{@name} says woof!"
  end

  def change_info(n, h, w)
    self.name = n
    self.height = h
    self.weight = w
  end

  def info
    "#{name} weighs #{weight} and is #{height} tall."
  end
end

makoto = GoodDog.new("Makoto", "15 inches", "25 lbs")
puts makoto.speak
puts makoto.info
makoto.change_info("Mak", "16 inches", "30 lbs")
puts makoto.info