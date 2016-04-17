class PigLatin
  attr_accessor :words

  def initialize
  end

  def translate(words)
    @words = words.split(' ')
    
  end

end